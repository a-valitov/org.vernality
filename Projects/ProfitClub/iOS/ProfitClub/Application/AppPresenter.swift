//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/24/20
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
import Main
import PCAuthentication
import ProfitClubModel
import PCUserService
import ErrorPresenter

final class AppPresenter {
    init(factory: AppFactory) {
        self.factory = factory
    }

    func present(in window: UIWindow?) {
        window?.rootViewController = self.factory.main(output: self)
        window?.makeKeyAndVisible()
    }

    private let factory: AppFactory

    // services
    private lazy var userService: PCUserService = {
        return self.factory.userService()
    }()

    // presenters
    private lazy var errorPresenter: ErrorPresenter = {
        return self.factory.errorPresenter()
    }()

    // helpers
    private var isLoggedIn: Bool {
        return self.userService.user != nil
    }
}

extension AppPresenter: MainModuleOutput {
    func mainDidLoad(module: MainModule) {
        if self.isLoggedIn {
            self.userService.reload { [weak self] result in
                switch result {
                case .success:
                    if self?.userService.isOnReview() ?? false {
                        let review = self?.factory.review(output: self)
                        review?.start(in: module)
                    } else {
                        let interface = self?.factory.interface(output: self)
                        interface?.start(in: module)
                    }
                case .failure(let error):
                    self?.errorPresenter.present(error)
                }
            }


        } else {
            let onboard = self.factory.onboard(output: self)
            onboard.start(in: module)
        }
    }
}

extension AppPresenter: OnboardModuleOutput {
    func onboard(module: OnboardModule, didLogin user: PCUser, inside main: MainModule?) {
        let interface = self.factory.interface(output: self)
        interface.start(in: main)
    }
}

extension AppPresenter: InterfaceModuleOutput {

}

extension AppPresenter: ReviewModuleOutput {

}

