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

protocol OrganizationProfileRouterDelegate: class {
    func organizationProfile(router: OrganizationProfileRouter, didUpdate organization: PCOrganization)
}

final class OrganizationProfileRouter {
    var viewController: UIViewController {
        return self.organizationProfileModule.viewController
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
    weak var delegate: OrganizationProfileRouterDelegate?

    init(user: PCUser, organization: PCOrganization) {
        self.user = user
        self.organization = organization
    }

    private var organizationProfileModule: OrganizationProfileModule {
        if let organizationProfileModule = self.weakOrganizationProfileModule {
            return organizationProfileModule
        } else {
            let organizationProfileModule = self.organizationProfileFactory(
                user: self.user,
                organization: self.organization
            ).make(organization: organization, output: self)
            organizationProfileModule.router = self
            self.weakOrganizationProfileModule = organizationProfileModule
            return organizationProfileModule
        }
    }
    private weak var weakOrganizationProfileModule: OrganizationProfileModule?

    private let user: PCUser
    private let organization: PCOrganization
    private weak var weakNavigationController: UINavigationController?
}

// MARK: - ModuleOutput
extension OrganizationProfileRouter: OrganizationProfileModuleOutput {
    func organizationProfile(module: OrganizationProfileModule,
                         didUpdate organization: PCOrganization) {
        self.delegate?.organizationProfile(router: self, didUpdate: organization)
    }
}

// MARK: - Factory
extension OrganizationProfileRouter: Router {
    func organizationProfileFactory(user: PCUser, organization: PCOrganization) -> OrganizationProfileFactory {
        return OrganizationProfileFactory(
            presenters: OrganizationProfilePresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter()
            ),
            services: OrganizationProfileServices(
                organization: self.organizationService(organization: organization)
            )
        )
    }
}
