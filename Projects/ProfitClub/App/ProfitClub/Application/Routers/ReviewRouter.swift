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
        if let adminRouter = self.weakAdminRouter {
            adminRouter.route(to: action)
        } else  {
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                DispatchQueue.main.async { [weak self] in
                    guard let sSelf = self else { return }
                    let adminRouter = sSelf.adminRouter(user: sSelf.user)
                    CATransaction.begin()
                    CATransaction.setCompletionBlock {
                        DispatchQueue.main.async {
                            adminRouter.route(to: action)
                        }
                    }
                    sSelf.navigationController.pushViewController(
                        adminRouter.viewController,
                        animated: true
                    )
                    CATransaction.commit()
                }
            }
            self.navigationController.popToViewController(
                self.review.viewController,
                animated: true
            )
            CATransaction.commit()
        }
    }

    // modules
    private var review: ReviewModule {
        if let review = self.weakReview {
            return review
        } else {
            let review = self.reviewFactory(user: self.user).make(output: self)
            review.router = self
            self.weakReview = review
            return review
        }
    }
    private weak var weakReview: ReviewModule?

    // routers
    private func adminRouter(user: PCUser) -> AdminRouter {
        if let adminRouter = self.weakAdminRouter {
            return adminRouter
        } else {
            let adminRouter = AdminRouter(user: user)
            adminRouter.delegate = self
            self.weakAdminRouter = adminRouter
            return adminRouter
        }
    }
    private weak var weakAdminRouter: AdminRouter?

    private func addRoleRouter(user: PCUser) -> AddRoleRouter {
        if let addRoleRouter = self.weakAddRoleRouter {
            return addRoleRouter
        } else {
            let addRoleRouter = AddRoleRouter(user: user)
            addRoleRouter.delegate = self
            self.weakAddRoleRouter = addRoleRouter
            return addRoleRouter
        }
    }
    private weak var weakAddRoleRouter: AddRoleRouter?

    private func organizationRouter(user: PCUser, organization: PCOrganization) -> OrganizationRouter {
        if let organizationRouter = self.weakOrganizationRouter {
            return organizationRouter
        } else {
            let organizationRouter = OrganizationRouter(user: user, organization: organization)
            organizationRouter.delegate = self
            self.weakOrganizationRouter = organizationRouter
            return organizationRouter
        }
    }
    private weak var weakOrganizationRouter: OrganizationRouter?

    private func supplierRouter(user: PCUser, supplier: PCSupplier) -> SupplierRouter {
        if let supplierRouter = self.weakSupplierRouter {
            return supplierRouter
        } else {
            let supplierRouter = SupplierRouter(user: user, supplier: supplier)
            supplierRouter.delegate = self
            self.weakSupplierRouter = supplierRouter
            return supplierRouter
        }
    }
    private weak var weakSupplierRouter: SupplierRouter?

    private func memberRouter(user: PCUser, member: PCMember) -> MemberRouter {
        if let memberRouter = self.weakMemberRouter {
            return memberRouter
        } else {
            let memberRouter = MemberRouter(user: user, member: member)
            memberRouter.delegate = self
            self.weakMemberRouter = memberRouter
            return memberRouter
        }
    }
    private weak var weakMemberRouter: MemberRouter?

    // state
    private let user: PCUser
    private weak var weakNavigationController: UINavigationController?
}

extension ReviewRouter: MemberRouterDelegate {
    func memberUserDidLogout(router: MemberRouter) {
        self.delegate?.reviewUserDidLogout(router: self)
    }

    func memberUserWantsToChangeRole(router: MemberRouter) {
        self.navigationController.popToViewController(
            self.viewController,
            animated: true
        )
    }
}

extension ReviewRouter: SupplierRouterDelegate {
    func supplierUserDidLogout(router: SupplierRouter) {
        self.delegate?.reviewUserDidLogout(router: self)
    }

    func supplierUserWantsToChangeRole(router: SupplierRouter) {
        self.navigationController.popToViewController(
            self.viewController,
            animated: true
        )
    }
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
        assert(supplier.status == .approved)
        self.navigationController.pushViewController(
            self.supplierRouter(
                user: self.user,
                supplier: supplier
            ).viewController,
            animated: true
        )
    }

    func review(module: ReviewModule, userWantsToEnter member: PCMember) {
        assert(member.status == .approved)
        self.navigationController.pushViewController(
            self.memberRouter(
                user: self.user,
                member: member
            ).viewController,
            animated: true
        )
    }
}
