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
import PCOrganization

protocol OrganizationRouterDelegate: class {
    func organizationUserDidLogout(router: OrganizationRouter)
    func organizationUserWantsToChangeRole(router: OrganizationRouter)
}

final class OrganizationRouter {
    var viewController: UIViewController {
        return self.organizationModule.viewController
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
    weak var delegate: OrganizationRouterDelegate?

    init(user: PCUser, organization: PCOrganization) {
        self.user = user
        self.organization = organization
    }

    private var organizationModule: OrganizationModule {
        if let organizationModule = self.weakOrganizationModule {
            return organizationModule
        } else {
            let organizationModule = self.organizationFactory(
                user: self.user,
                organization: self.organization
            ).make(organization: self.organization, output: self)
            organizationModule.router = self
            self.weakOrganizationModule = organizationModule
            return organizationModule
        }
    }
    private weak var weakOrganizationModule: OrganizationModule?

    private let user: PCUser
    private let organization: PCOrganization
    private weak var weakNavigationController: UINavigationController?
}

// MARK: - ModuleOutput
extension OrganizationRouter: OrganizationModuleOutput {
    func organization(module: OrganizationModule,
                      userWantsToOpenProfileOf organization: PCOrganization) {

    }

    func organizationUserDidLogout(module: OrganizationModule) {
        self.delegate?.organizationUserDidLogout(router: self)
    }

    func organizationUserWantsToChangeRole(module: OrganizationModule) {
        self.delegate?.organizationUserWantsToChangeRole(router: self)
    }
}

// MARK: - Factory
extension OrganizationRouter: Router {
    func organizationFactory(user: PCUser, organization: PCOrganization) -> OrganizationFactory {
        return OrganizationFactory(
            presenters: OrganizationPresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter(),
                confirmation: self.confirmationPresenter(),
                menu: self.menuPresenter()
            ),
            services: OrganizationServices(
                userService: self.userService(user: user),
                organization: self.organizationService(organization: organization)
            ),
            factories: OrganizationFactories()
        )
    }

}
