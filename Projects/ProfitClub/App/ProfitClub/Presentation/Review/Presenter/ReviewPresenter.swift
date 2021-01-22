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
import UIKit
import PCModel
import MenuPresenter
import ConfirmationPresenter

final class ReviewPresenter: ReviewModule {
    weak var output: ReviewModuleOutput?
    var viewController: UIViewController {
        if let view = self.weakView {
            return view
        } else {
            let user = self.services.userService.user
            let reviewView = ReviewViewAlpha()
            reviewView.output = self
            reviewView.members = user?.members?.map({ $0.any }) ?? []
            reviewView.organizations = user?.organizations?.map({ $0.any }) ?? []
            reviewView.suppliers = user?.suppliers?.map({ $0.any }) ?? []
            reviewView.isAdministrator = user?.roles?.contains(.administrator) ?? false
            self.weakView = reviewView
            return reviewView
        }
    }

    init(presenters: ReviewPresenters,
         services: ReviewServices) {
        self.presenters = presenters
        self.services = services
    }

    private let presenters: ReviewPresenters
    private let services: ReviewServices
    private weak var weakView: UIViewController?
}

extension ReviewPresenter: ReviewViewOutput {
    func reviewViewDidLoad(view: ReviewViewInput) {
        self.reloadUser(view: view)
    }

    func reviewUserDidTapOnAdmin(view: ReviewViewInput) {
        self.output?.reviewUserWantsToEnterAdmin(module: self)
    }

    func review(view: ReviewViewInput, userWantsToRefresh sender: Any) {
        self.reloadUser(view: view)
    }

    func review(view: ReviewViewInput, tappenOn menuBarButton: Any) {
        let addRole = MenuItem(title: "Добавить роль", image: #imageLiteral(resourceName: "addRoleIcon")) { [weak self] in
            guard let sSelf = self else { return }
            sSelf.output?.reviewUserWantsToAddRole(module: sSelf)
        }
        let logout = MenuItem(title: "Выйти", image: #imageLiteral(resourceName: "logout")) { [weak self] in
            guard let sSelf = self else { return }
            sSelf.presenters.confirmation.present(title: "Подтвердите выход", message: "Вы уверены что хотите выйти?", actionTitle: "Выйти", withCancelAction: true) { [weak sSelf] in
                guard let ssSelf = sSelf else { return }
                ssSelf.output?.reviewUserWantsToLogout(module: ssSelf)
            }
        }
        self.presenters.menu.present(items: [addRole, logout])
    }

    func review(view: ReviewViewInput, userTappedOn supplier: PCSupplier) {
        if supplier.status == .approved {
            self.output?.review(module: self, userWantsToEnter: supplier)
        }
    }

    func review(view: ReviewViewInput, userTappedOn organization: PCOrganization) {
        if organization.status == .approved {
            self.output?.review(module: self, userWantsToEnter: organization)
        }
    }

    func review(view: ReviewViewInput, userTappedOn member: PCMember) {
        if member.status == .approved {
            self.output?.review(module: self, userWantsToEnter: member)
        }
    }

    private func reloadUser(view: ReviewViewInput) {
        self.services.userService.reload { [weak self] result in
            switch result {
            case .success(let user):
                view.isAdministrator = user.roles?.contains(.administrator) ?? false
                view.members = user.members?.map({ $0.any }) ?? []
                view.organizations = user.organizations?.map({ $0.any }) ?? []
                view.suppliers = user.suppliers?.map({ $0.any }) ?? []
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }
}
