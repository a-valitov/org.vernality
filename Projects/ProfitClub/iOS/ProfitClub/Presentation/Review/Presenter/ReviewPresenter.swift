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
        self.router?.openReview(self.services.userService.user, output: self)
    }

    private let presenters: ReviewPresenters
    private let services: ReviewServices
}

extension ReviewPresenter: ReviewViewOutput {
    func review(view: ReviewViewInput, userWantsToRefresh sender: Any) {
        self.services.userService.reload { [weak self] result in
            switch result {
            case .success(let user):
                view.member = user.member?.any
                view.organizations = user.organizations?.map({ $0.any }) ?? []
                view.suppliers = user.suppliers?.map({ $0.any }) ?? []
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }

    func review(view: ReviewViewInput, userWantsToAdd sender: Any) {

    }

    func review(view: ReviewViewInput, userWantsToLogout sender: Any) {
        self.output?.review(module: self, userWantsToLogoutInside: self.router?.main)
    }
}
