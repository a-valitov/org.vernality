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
import ActivityPresenter

final class AppPresenter {
    init(factory: AppFactory) {
        self.factory = factory
    }

    func present(in window: UIWindow?) {
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().barStyle = .blackTranslucent
        window?.rootViewController = self.factory.main(output: self)
        window?.makeKeyAndVisible()
    }

    private let factory: AppFactory

    // services
    private lazy var userService: PCUserService = {
        return self.factory.userService
    }()

    // presenters
    private lazy var errorPresenter: ErrorPresenter = {
        return self.factory.errorPresenter()
    }()

    private lazy var activityPresenter: ActivityPresenter = {
        return self.factory.activityPresenter()
    }()

    // helpers
    private var isLoggedIn: Bool {
        return self.userService.user != nil
    }
}

extension AppPresenter: MainModuleOutput {
    func mainDidLoad(module: MainModule) {
        if self.isLoggedIn {
            let review = self.factory.review(output: self)
            review.start(in: module)
        } else {
            let onboard = self.factory.onboard(output: self)
            onboard.start(in: module)
        }
    }
}

extension AppPresenter: OnboardModuleOutput {
    func onboard(module: OnboardModule, didAddSupplier supplier: PCSupplier, inside main: MainModule?) {
        let review = self.factory.review(output: self)
        review.start(in: main)
    }

    func onboard(module: OnboardModule, didAddOrganization organization: PCOrganization, inside main: MainModule?) {
        let review = self.factory.review(output: self)
        review.start(in: main)
    }

    func onboard(module: OnboardModule, didAddMember member: PCMember, inside main: MainModule?) {
        let review = self.factory.review(output: self)
        review.start(in: main)
    }

    func onboard(module: OnboardModule, didLogin user: PCUser, inside main: MainModule?) {
        let review = self.factory.review(output: self)
        review.start(in: main)
    }

    func onboard(module: OnboardModule, didRegister user: PCUser, inside main: MainModule?) {
        let review = self.factory.review(output: self)
        review.start(in: main)
    }
}

extension AppPresenter: ReviewModuleOutput {
    func review(module: ReviewModule, userWantsToLogoutInside main: MainModule?) {
        self.userService.logout { [weak self] result in
            switch result {
            case .failure(let error):
                self?.errorPresenter.present(error)
            case .success:
                main?.unwindToRoot()
                let onboard = self?.factory.onboard(output: self)
                onboard?.start(in: main)
            }
        }
    }

    func review(module: ReviewModule, userWantsToAddRoleInside main: MainModule?) {
        let onboard = self.factory.onboard(output: self)
        onboard.onboard(in: main)
    }
}

