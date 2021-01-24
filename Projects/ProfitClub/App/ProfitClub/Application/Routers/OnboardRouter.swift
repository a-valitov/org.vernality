//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Rinat Enikeev on 24.01.2021
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
import PCOnboard

protocol OnboardRouterDelegate: class {
    func onboard(router: OnboardRouter, didLogin user: PCUser)
    func onboard(router: OnboardRouter, didRegister user: PCUser)
}

final class OnboardRouter {
    var viewController: UIViewController {
        return self.onboard.viewController
    }
    var navigationController: UINavigationController {
        if let navigationController = self.viewController.navigationController {
            return navigationController
        } else if let navigationController = self.weakNavigationController {
            return navigationController
        } else {
            let navigationController = UINavigationController(
                rootViewController: self.viewController
            )
            self.weakNavigationController = navigationController
            return navigationController
        }
    }
    weak var delegate: OnboardRouterDelegate?

    private var onboard: OnboardModule {
        if let onboard = self.weakOnboard {
            return onboard
        } else {
            let onboard = self.onboardFactory().make(output: self)
            self.weakOnboard = onboard
            return onboard
        }
    }
    private weak var weakOnboard: OnboardModule?

    private weak var weakNavigationController: UINavigationController?
}

// MARK: - ModuleOutput
extension OnboardRouter: OnboardModuleOutput {
    func onboard(module: OnboardModule, didLogin user: PCUser) {
        self.delegate?.onboard(router: self, didLogin: user)
    }

    func onboard(module: OnboardModule, didRegister user: PCUser) {
        self.delegate?.onboard(router: self, didRegister: user)
    }
}

// MARK: - Factories
extension OnboardRouter: Router {
    private func onboardFactory() -> OnboardFactory {
        return OnboardFactory(
            presenters: OnboardPresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter(),
                confirmation: self.confirmationPresenter()
            ),
            services: OnboardServices(
                authentication: self.authenticationService()
            )
        )
    }
}
