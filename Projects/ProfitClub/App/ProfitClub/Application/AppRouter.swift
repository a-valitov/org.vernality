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
import PCUserPersistence
import PCActionService
import PCCommercialOfferService
import ErrorPresenter
import ConfirmationPresenter
import PCModel

final class AppRouter {
    var viewController: UIViewController {
        return self.navigationController
    }

    init(userPersistence: PCUserPersistence) {
        self.userPersistence = userPersistence
    }
    
    private var navigationController: UINavigationController {
        if let navigationController = self.weakNavigationController {
            return navigationController
        } else {
            let rootViewController: UIViewController
            if let user = self.userPersistence.user {
                if let lastUsedRole = self.userPersistence.lastUsedRole {
                    switch lastUsedRole {
                    case .administrator:
                        rootViewController = self.adminRouter(user: user).viewController
                    case .member(let member):
                        rootViewController = self.memberRouter(user: user, member: member).viewController
                    case .organization(let organization):
                        rootViewController = self.organizationRouter(user: user, organization: organization).viewController
                    case .supplier(let supplier):
                        rootViewController = self.supplierRouter(user: user, supplier: supplier).viewController
                    }
                } else {
                    rootViewController = self.reviewRouter(user: user).viewController
                }
            } else {
                rootViewController = self.onboardRouter().viewController
            }
            let navigationController = UINavigationController(rootViewController: rootViewController)
            self.weakNavigationController = navigationController
            return navigationController
        }
    }
    private weak var weakNavigationController: UINavigationController?

    // persistence
    private var userPersistence: PCUserPersistence

    // routers
    private func reviewRouter(user: PCUser) -> ReviewRouter {
        if let reviewRouter = self.weakReviewRouter {
            return reviewRouter
        } else {
            let reviewRouter = ReviewRouter(user: user, userPersistence: self.userPersistence)
            reviewRouter.delegate = self
            self.weakReviewRouter = reviewRouter
            return reviewRouter
        }
    }
    private weak var weakReviewRouter: ReviewRouter?

    private func onboardRouter() -> OnboardRouter {
        if let onboardRouter = self.weakOnboardRouter {
            return onboardRouter
        } else {
            let onboardRouter = OnboardRouter()
            onboardRouter.delegate = self
            self.weakOnboardRouter = onboardRouter
            return onboardRouter
        }
    }
    private weak var weakOnboardRouter: OnboardRouter?

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

    func organizationRouter(user: PCUser, organization: PCOrganization) -> OrganizationRouter {
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

    func supplierRouter(user: PCUser, supplier: PCSupplier) -> SupplierRouter {
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

    func memberRouter(user: PCUser, member: PCMember) -> MemberRouter {
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
}

extension AppRouter: MemberRouterDelegate {
    func memberUserDidLogout(router: MemberRouter) {
        self.onLogout()
    }

    func memberUserWantsToChangeRole(router: MemberRouter) {
        self.onChangeRole(user: router.user)
    }
}

extension AppRouter: SupplierRouterDelegate {
    func supplierUserDidLogout(router: SupplierRouter) {
        self.onLogout()
    }

    func supplierUserWantsToChangeRole(router: SupplierRouter) {
        self.onChangeRole(user: router.user)
    }
}

extension AppRouter: OrganizationRouterDelegate {
    func organizationUserDidLogout(router: OrganizationRouter) {
        self.onLogout()
    }

    func organizationUserWantsToChangeRole(router: OrganizationRouter) {
        self.onChangeRole(user: router.user)
    }
}

extension AppRouter: AdminRouterDelegate {
    func adminUserDidLogout(router: AdminRouter) {
        self.onLogout()
    }

    func adminUserWantsToChangeRole(router: AdminRouter) {
        self.onChangeRole(user: router.user)
    }
}

// MARK: - Push Notifications handling
extension AppRouter {
    func handle(push: AppPush) {
        switch push {
        case .actionCreated(let actionId):
            self.openAdminAction(actionId: actionId)
        case .commercialOfferCreated(let commercialOfferId):
            self.openAdminCommercialOffer(commercialOfferId: commercialOfferId)
        case .organizationCreated(let organizationId):
            self.openAdminOrganization(organizationId: organizationId)
        case .supplierCreated(let supplierId):
            self.openAdminSupplier(supplierId: supplierId)
        case .memberCreated(let memberId):
            self.openAdminMember(memberId: memberId)
        }
    }

    private func openAdminAction(actionId: String) {
        self.confirm(message: "Открыть экран акции?") { [weak self] in
            let actionService = self?.actionService()
            actionService?.fetch(actionId) { [weak self] result in
                guard let sSelf = self else { return }
                switch result {
                case .success(let action):
                    self?.weakReviewRouter?.route(to: action)
                case .failure(let error):
                    sSelf.errorPresenter().present(error)
                }
            }
        }
    }
    
    private func openAdminCommercialOffer(commercialOfferId: String) {
        self.confirm(message: "Открыть экран коммерческого предложения?") { [weak self] in
            let commercialOfferService = self?.commercialOfferService()
            commercialOfferService?.fetch(commercialOfferId) { [weak self] result in
                guard let sSelf = self else { return }
                switch result {
                case .success(let commercialOffer):
                    self?.weakReviewRouter?.route(to: commercialOffer)
                case .failure(let error):
                    sSelf.errorPresenter().present(error)
                }
            }
        }
    }
    
    private func openAdminOrganization(organizationId: String) {
        print(organizationId)
    }
    
    private func openAdminSupplier(supplierId: String) {
        print(supplierId)
    }
    
    private func openAdminMember(memberId: String) {
        print(memberId)
    }

    private func confirm(message: String, completion: @escaping () -> Void) {
        let confirmationPresenter = self.confirmationPresenter()
        confirmationPresenter.present(
            title: "Подтверждение",
            message: message,
            actionTitle: "Открыть",
            withCancelAction: true,
            completion: completion
        )
    }
}

extension AppRouter: OnboardRouterDelegate {
    func onboard(router: OnboardRouter, didLogin user: PCUser) {
        self.navigationController.setViewControllers(
            [self.reviewRouter(user: user).viewController],
            animated: true
        )
    }

    func onboard(router: OnboardRouter, didRegister user: PCUser) {
        self.navigationController.setViewControllers(
            [self.reviewRouter(user: user).viewController],
            animated: true
        )
    }
}

extension AppRouter: ReviewRouterDelegate {
    func reviewUserDidLogout(router: ReviewRouter) {
        self.onLogout()
    }
}


extension AppRouter {
    private func onLogout() {
        self.userPersistence.lastUsedRole = nil
        self.userPersistence.user = nil
        self.navigationController.setViewControllers(
            [self.onboardRouter().viewController],
            animated: true
        )
    }

    private func onChangeRole(user: PCUser) {
        self.userPersistence.lastUsedRole = nil
        self.navigationController.setViewControllers(
            [self.reviewRouter(user: user).viewController],
            animated: true
        )
    }
}
extension AppRouter {
    private func errorPresenter() -> ErrorPresenter {
        return ErrorPresenterAlertFactory().make()
    }
    private func confirmationPresenter() -> ConfirmationPresenter {
        return ConfirmationPresenterAlertFactory().make()
    }
    private func actionService() -> PCActionService {
        return PCActionServiceParseFactory().make()
    }
    private func commercialOfferService() -> PCCommercialOfferService {
        return PCCommercialOfferServiceParseFactory().make()
    }
}
