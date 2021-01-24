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
import PCAddRole

protocol AddRoleRouterDelegate: class {
    func addRole(router: AddRoleRouter, didAdd organization: PCOrganization)
    func addRole(router: AddRoleRouter, didAdd supplier: PCSupplier)
    func addRole(router: AddRoleRouter, didAdd member: PCMember)
}

final class AddRoleRouter {
    var viewController: UIViewController {
        return self.addRole.viewController
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
    weak var delegate: AddRoleRouterDelegate?

    init(user: PCUser) {
        self.user = user
    }

    private var addRole: AddRoleModule {
        if let addRole = self.weakAddRole {
            return addRole
        } else {
            let addRole = self.addRoleFactory(user: self.user).make(output: self)
            addRole.router = self
            self.weakAddRole = addRole
            return addRole
        }
    }
    private weak var weakAddRole: AddRoleModule?

    private let user: PCUser
    private weak var weakNavigationController: UINavigationController?
}

// MARK: - ModuleOutput
extension AddRoleRouter: AddRoleModuleOutput {
    func addRole(module: AddRoleModule, didAddSupplier supplier: PCSupplier) {
        self.delegate?.addRole(router: self, didAdd: supplier)
    }

    func addRole(module: AddRoleModule, didAddOrganization organization: PCOrganization) {
        self.delegate?.addRole(router: self, didAdd: organization)
    }

    func addRole(module: AddRoleModule, didAddMember member: PCMember) {
        self.delegate?.addRole(router: self, didAdd: member)
    }
}

// MARK: - Factories
extension AddRoleRouter: Router {
    private func addRoleFactory(user: PCUser) -> AddRoleFactory {
        return AddRoleFactory(
            presenters: AddRolePresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter(),
                confirmation: self.confirmationPresenter()
            ),
            services: AddRoleServices(
                user: self.userService(user: user)
            )
        )
    }
}
