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
import PCAuthentication
import PCModel
import PCUserService
import ErrorPresenter
import ActivityPresenter
import PCOnboard
import PCReview
import PCUserPersistence
import PCAdmin

final class AppRouter {
    var viewController: UIViewController {
        return self.navigationController
    }

    init(factory: AppFactory) {
        self.factory = factory
    }

    private let factory: AppFactory

    private var navigationController: UINavigationController {
        if let navigationController = self.weakNavigationController {
            return navigationController
        } else {
            let rootViewController: UIViewController
            if let user = self.userPersistence.user {
                rootViewController = self.reviewRouter(user: user).viewController
            } else {
                rootViewController = self.onboard.viewController
            }
            let navigationController = UINavigationController(rootViewController: rootViewController)
            self.weakNavigationController = navigationController
            return navigationController
        }
    }
    private weak var weakNavigationController: UINavigationController?

    // persistence
    private lazy var userPersistence: PCUserPersistence = {
        return self.factory.userPersistence
    }()

    // presenters
    private lazy var errorPresenter: ErrorPresenter = {
        return self.factory.errorPresenter()
    }()

    private lazy var activityPresenter: ActivityPresenter = {
        return self.factory.activityPresenter()
    }()

    // helpers
    private var isAdministrator: Bool {
        return self.userPersistence.user?.roles?.contains(.administrator) ?? false
    }

    // modules construction
    private var onboard: OnboardModule {
        if let onboard = self.weakOnboard {
            return onboard
        } else {
            let onboard = self.factory.onboard(output: self)
            self.weakOnboard = onboard
            return onboard
        }
    }
    private func supplier(for supplier: PCSupplier) -> SupplierModule {
        if let supplier = self.weakSupplier {
            return supplier
        } else {
            let supplier = self.factory.supplier(supplier: supplier, output: self)
            self.weakSupplier = supplier
            return supplier
        }
    }
    private func member(for member: PCMember) -> MemberModule {
        if let member = self.weakMember {
            return member
        } else {
            let member = self.factory.member(member: member, output: self)
            self.weakMember = member
            return member
        }
    }
    private func profile(for organization: PCOrganization) -> OrganizationProfileModule {
        if let profile = self.weakOrganizationProfile {
            return profile
        } else {
            let profile = self.factory.organizationProfile(organization: organization, output: self)
            self.weakOrganizationProfile = profile
            return profile
        }
    }
    private func profile(for supplier: PCSupplier) -> SupplierProfileModule {
        if let profile = self.weakSupplierProfile {
            return profile
        } else {
            let profile = self.factory.supplierProfile(supplier: supplier, output: self)
            self.weakSupplierProfile = profile
            return profile
        }
    }
    private func profile(for member: PCMember) -> MemberProfileModule {
        if let profile = self.weakMemberProfile {
            return profile
        } else {
            let profile = self.factory.memberProfile(member: member, output: self)
            self.weakMemberProfile = profile
            return profile
        }
    }

    // routers
    private func reviewRouter(user: PCUser) -> ReviewRouter {
        if let reviewRouter = self.strongReviewRouter {
            return reviewRouter
        } else {
            let reviewRouter = ReviewRouter(user: user)
            reviewRouter.delegate = self
            self.strongReviewRouter = reviewRouter
            return reviewRouter
        }
    }
    private var strongReviewRouter: ReviewRouter?

    // weak modules
    private weak var weakMemberProfile: MemberProfileModule?
    private weak var weakSupplierProfile: SupplierProfileModule?
    private weak var weakOrganizationProfile: OrganizationProfileModule?
    private weak var weakMember: MemberModule?
    private weak var weakSupplier: SupplierModule?
    private weak var weakOnboard: OnboardModule?
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
        let actionService = self.factory.actionService()
        actionService.fetch(actionId) { [weak self] result in
            guard let sSelf = self else { return }
            switch result {
            case .success(let action):
                self?.strongReviewRouter?.route(to: action)
            case .failure(let error):
                sSelf.errorPresenter.present(error)
            }
        }
    }
    
    private func openAdminCommercialOffer(commercialOfferId: String) {
        print(commercialOfferId)
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
}

extension AppRouter: ReviewRouterDelegate {
    func reviewUserDidLogout(router: ReviewRouter) {
        self.navigationController.setViewControllers(
            [self.onboard.viewController],
            animated: true
        )
    }
}

extension AppRouter: OnboardModuleOutput {
    func onboard(module: OnboardModule, didLogin user: PCUser) {
        self.navigationController.setViewControllers(
            [self.reviewRouter(user: user).viewController],
            animated: true
        )
    }

    func onboard(module: OnboardModule, didRegister user: PCUser) {
        self.navigationController.setViewControllers(
            [self.reviewRouter(user: user).viewController],
            animated: true
        )
    }
}

extension AppRouter: OrganizationModuleOutput {
    func organization(module: OrganizationModule, userWantsToOpenProfileOf organization: PCOrganization) {
        let organizationProfileModule = self.profile(for: organization)
        self.navigationController.pushViewController(organizationProfileModule.viewController, animated: true)
    }
    func organizationUserDidLogout(module: OrganizationModule) {
        self.logout()
    }
    func organizationUserWantsToChangeRole(module: OrganizationModule) {
        if let reviewViewController = self.strongReviewRouter?.viewController {
            self.navigationController.popToViewController(
                reviewViewController,
                animated: true
            )
        } else {
            assertionFailure("Unable to unwind to Review module")
        }
    }
}

extension AppRouter: SupplierModuleOutput {
    func supplier(module: SupplierModule, userWantsToOpenProfileOf supplier: PCSupplier) {
        let supplierProfileModule = self.profile(for: supplier)
        self.navigationController.pushViewController(supplierProfileModule.viewController, animated: true)
    }
    
    func supplierUserWantsToLogout(module: SupplierModule) {
        self.logout()
    }

    func supplierUserWantsToChangeRole(module: SupplierModule) {
        if let reviewViewController = self.strongReviewRouter?.viewController {
            self.navigationController.popToViewController(
                reviewViewController,
                animated: true
            )
        } else {
            assertionFailure("Unable to unwind to Review module")
        }
    }
}

extension AppRouter: MemberModuleOutput {
    func member(module: MemberModule, userWantsToOpenProfileOf member: PCMember) {
        let memberProfileModule = self.profile(for: member)
        self.navigationController.pushViewController(memberProfileModule.viewController, animated: true)
    }
    
    func memberUserWantsToLogout(module: MemberModule) {
        self.logout()
    }

    func memberUserWantsToChangeRole(module: MemberModule) {
        if let reviewViewController = self.strongReviewRouter?.viewController {
            self.navigationController.popToViewController(
                reviewViewController,
                animated: true
            )
        } else {
            assertionFailure("Unable to unwind to Review module")
        }
    }
}

extension AppRouter: MemberProfileModuleOutput {
    func memberProfile(module: MemberProfileModule, didUpdate member: PCMember) {
        self.weakMember?.member = member
    }
}

extension AppRouter: OrganizationProfileModuleOutput {
    func organizationProfile(module: OrganizationProfileModule, didUpdate organization: PCOrganization) {
//        self.weakOrganization?.organization = organization
    }
}

extension AppRouter: SupplierProfileModuleOutput {
    func supplierProfile(module: SupplierProfileModule, didUpdate supplier: PCSupplier) {
        self.weakSupplier?.supplier = supplier
    }
}

extension AppRouter: AdminModuleOutput {
    func adminUserDidLogout(module: AdminModule) {
        self.logout()
    }

    func adminUserWantsToChangeRole(module: AdminModule) {
        if let reviewViewController = self.strongReviewRouter?.viewController {
            self.navigationController.popToViewController(
                reviewViewController,
                animated: true
            )
        } else {
            assertionFailure("Unable to unwind to Review module")
        }
    }
}

// MARK: - Private
extension AppRouter {
    private func logout() {
//        self.userService.logout { [weak self] result in
//            guard let sSelf = self else { return }
//            switch result {
//            case .failure(let error):
//                sSelf.errorPresenter.present(error)
//            case .success:
//                sSelf.navigationController.setViewControllers([sSelf.onboard.viewController], animated: true)
//            }
//        }
    }
}
