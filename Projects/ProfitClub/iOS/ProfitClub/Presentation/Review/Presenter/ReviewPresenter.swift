//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/30/20
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

import Foundation
import Main
import ProfitClubModel
import MenuPresenter
import ConfirmationPresenter

final class ReviewPresenter: ReviewModule {
    var router: ReviewRouter?
    weak var output: ReviewModuleOutput?

    init(presenters: ReviewPresenters,
         services: ReviewServices) {
        self.presenters = presenters
        self.services = services
    }

    func start(in main: MainModule?) {
        self.router?.main = main
        self.presenters.activity.increment()
        self.services.userService.reload { result in
            self.presenters.activity.decrement()
            switch result {
            case .success(let user):
                self.router?.openReview(user, output: self)
            case .failure(let error):
                self.presenters.error.present(error)
            }
        }
    }

    private let presenters: ReviewPresenters
    private let services: ReviewServices
}

extension ReviewPresenter: ReviewViewOutput {
    func reviewUserDidTapOnAdmin(view: ReviewViewInput) {
        self.output?.review(module: self, userWantsToEnterAdminInsideMain: self.router?.main)
    }

    func review(view: ReviewViewInput, userWantsToRefresh sender: Any) {
        self.services.userService.reload { [weak self] result in
            switch result {
            case .success(let user):
                view.members = user.members?.map({ $0.any }) ?? []
                view.organizations = user.organizations?.map({ $0.any }) ?? []
                view.suppliers = user.suppliers?.map({ $0.any }) ?? []
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }

    func review(view: ReviewViewInput, tappenOn menuBarButton: Any) {
        self.presenters.menu.present(menuFor: .review, logout: { [weak self] in
            guard let sSelf = self else { return }
            sSelf.presenters.confirmation.present(title: "Подтвердите выход", message: "Вы уверены что хотите выйти?", actionTitle: "Выйти", withCancelAction: true) { [weak sSelf] in
                guard let ssSelf = sSelf else { return }
                ssSelf.output?.review(module: ssSelf, userWantsToLogoutInside: ssSelf.router?.main)
            }
        }, changeRole: nil, openProfile: nil) { [weak self] in
            guard let sSelf = self else { return }
            sSelf.output?.review(module: sSelf, userWantsToAddRoleInside: sSelf.router?.main)
        }
    }

    func review(view: ReviewViewInput, userTappedOn supplier: PCSupplier) {
        if supplier.status == .approved {
            self.output?.review(module: self, userWantsToEnter: supplier, inside: self.router?.main)
        }
    }

    func review(view: ReviewViewInput, userTappedOn organization: PCOrganization) {
        if organization.status == .approved {
            self.output?.review(module: self, userWantsToEnter: organization, inside: self.router?.main)
        }
    }

    func review(view: ReviewViewInput, userTappedOn member: PCMember) {
        if member.status == .approved {
            self.output?.review(module: self, userWantsToEnter: member, inside: self.router?.main)
        }
    }
}
