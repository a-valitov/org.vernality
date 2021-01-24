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
import PCModel
import PCReview

protocol ReviewRouterDelegate: class {
    func reviewUserDidLogout(router: ReviewRouter)
}

final class ReviewRouter {
    var viewController: UIViewController {
        return self.review.viewController
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
    weak var delegate: ReviewRouterDelegate?

    init(user: PCUser) {
        self.user = user
    }

    func route(to action: PCAction) {
        self.strongAdminRouter?.route(to: action)
    }

    // modules
    private var review: ReviewModule {
        if let review = self.weakReview {
            return review
        } else {
            let review = self.reviewFactory(user: self.user).make(output: self)
            self.weakReview = review
            return review
        }
    }
    private weak var weakReview: ReviewModule?

    // routers
    private func adminRouter(user: PCUser) -> AdminRouter {
        if let adminRouter = self.strongAdminRouter {
            return adminRouter
        } else {
            let adminRouter = AdminRouter(user: user)
            adminRouter.delegate = self
            self.strongAdminRouter = adminRouter
            return adminRouter
        }
    }
    private var strongAdminRouter: AdminRouter?

    private func addRoleRouter(user: PCUser) -> AddRoleRouter {
        if let addRoleRouter = self.strongAddRoleRouter {
            return addRoleRouter
        } else {
            let addRoleRouter = AddRoleRouter(user: user)
            addRoleRouter.delegate = self
            self.strongAddRoleRouter = addRoleRouter
            return addRoleRouter
        }
    }
    private var strongAddRoleRouter: AddRoleRouter?

    private func organizationRouter(user: PCUser, organization: PCOrganization) -> OrganizationRouter {
        if let organizationRouter = self.strongOrganizationRouter {
            return organizationRouter
        } else {
            let organizationRouter = OrganizationRouter(user: user, organization: organization)
            organizationRouter.delegate = self
            self.strongOrganizationRouter = organizationRouter
            return organizationRouter
        }
    }
    private var strongOrganizationRouter: OrganizationRouter?

    // state
    private let user: PCUser
    private weak var weakNavigationController: UINavigationController?
}

extension ReviewRouter: OrganizationRouterDelegate {
    func organizationUserDidLogout(router: OrganizationRouter) {
        self.delegate?.reviewUserDidLogout(router: self)
    }

    func organizationUserWantsToChangeRole(router: OrganizationRouter) {
        self.navigationController.popToViewController(
            self.viewController,
            animated: true
        )
    }
}

extension ReviewRouter: AdminRouterDelegate {
    func adminUserDidLogout(router: AdminRouter) {
        self.delegate?.reviewUserDidLogout(router: self)
    }

    func adminUserWantsToChangeRole(router: AdminRouter) {
        self.navigationController.popToViewController(
            self.viewController,
            animated: true
        )
    }
}

// MARK: - AddRoleRouterDelegate
extension ReviewRouter: AddRoleRouterDelegate {
    func addRole(router: AddRoleRouter, didAdd organization: PCOrganization) {
        self.navigationController.popToViewController(
            self.viewController,
            animated: true
        )
    }

    func addRole(router: AddRoleRouter, didAdd supplier: PCSupplier) {
        self.navigationController.popToViewController(
            self.viewController,
            animated: true
        )
    }

    func addRole(router: AddRoleRouter, didAdd member: PCMember) {
        self.navigationController.popToViewController(
            self.viewController,
            animated: true
        )
    }
}

// MARK: - Factory
extension ReviewRouter: Router {
    private func reviewFactory(user: PCUser) -> ReviewFactory {
        return ReviewFactory(
            presenters: ReviewPresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter(),
                confirmation: self.confirmationPresenter(),
                menu: self.menuPresenter()
            ),
            services: ReviewServices(
                userService: self.userService(user: user)
            )
        )
    }
}

// MARK: - ModuleOutput
extension ReviewRouter: ReviewModuleOutput {
    func reviewUserDidLogout(module: ReviewModule) {
        self.delegate?.reviewUserDidLogout(router: self)
    }

    func reviewUserWantsToAddRole(module: ReviewModule) {
        self.navigationController.pushViewController(
            self.addRoleRouter(user: self.user).viewController,
            animated: true
        )
    }

    func reviewUserWantsToEnterAdmin(module: ReviewModule) {
        self.navigationController.pushViewController(
            self.adminRouter(user: self.user).viewController,
            animated: true
        )
    }

    func review(module: ReviewModule, userWantsToEnter organization: PCOrganization) {
        assert(organization.status == .approved)
        self.navigationController.pushViewController(
            self.organizationRouter(
                user: self.user,
                organization: organization
            ).viewController,
            animated: true
        )
    }

    func review(module: ReviewModule, userWantsToEnter supplier: PCSupplier) {
//        assert(supplier.status == .approved)
//        let supplierModule = self.supplier(for: supplier)
//        self.navigationController.pushViewController(supplierModule.viewController, animated: true)
    }

    func review(module: ReviewModule, userWantsToEnter member: PCMember) {
//        assert(member.status == .approved)
//        let memberModule = self.member(for: member)
//        self.navigationController.pushViewController(memberModule.viewController, animated: true)
    }
}
