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

final class AppPresenter {
    init(factory: AppFactory) {
        self.factory = factory
    }

    func present(in window: UIWindow?) {
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().barStyle = .black
        window?.rootViewController = self.navigationController
        window?.makeKeyAndVisible()
    }

    private let factory: AppFactory

    private var navigationController: UINavigationController {
        if let navigationController = self.weakNavigationController {
            return navigationController
        } else {
            let rootViewController: UIViewController
            if self.isLoggedIn {
                rootViewController = self.review.viewController
            } else {
                rootViewController = self.onboard.viewController
            }
            let navigationController = UINavigationController(rootViewController: rootViewController)
            self.weakNavigationController = navigationController
            return navigationController
        }
    }
    private weak var weakNavigationController: UINavigationController?

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

    private var isAdministrator: Bool {
        return self.userService.user?.roles?.contains(.administrator) ?? false
    }

    // modules construction
    private var review: ReviewModule {
        if let review = self.weakReview {
            return review
        } else {
            let review = self.factory.review(output: self)
            self.weakReview = review
            return review
        }
    }

    private var onboard: OnboardModule {
        if let onboard = self.weakOnboard {
            return onboard
        } else {
            let onboard = self.factory.onboard(output: self)
            self.weakOnboard = onboard
            return onboard
        }
    }

    private var addRole: AddRoleModule {
        if let addRole = self.weakAddRole {
            return addRole
        } else {
            let addRole = self.factory.addRole(output: self)
            self.weakAddRole = addRole
            return addRole
        }
    }
    private var admin: AdminModule {
        if let admin = self.weakAdmin {
            return admin
        } else {
            let admin = self.factory.admin(output: self)
            self.weakAdmin = admin
            return admin
        }
    }
    private func organization(for organization: PCOrganization) -> OrganizationModule {
        if let organization = self.weakOrganization {
            return organization
        } else {
            let organization = self.factory.organization(organization, output: self)
            self.weakOrganization = organization
            return organization
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

    // weak modules
    private weak var weakMemberProfile: MemberProfileModule?
    private weak var weakSupplierProfile: SupplierProfileModule?
    private weak var weakOrganizationProfile: OrganizationProfileModule?
    private weak var weakMember: MemberModule?
    private weak var weakOrganization: OrganizationModule?
    private weak var weakSupplier: SupplierModule?
    private weak var weakAdmin: AdminModule?
    private weak var weakReview: ReviewModule?
    private weak var weakOnboard: OnboardModule?
    private weak var weakAddRole: AddRoleModule?
}

// MARK: - Push Notifications handling
extension AppPresenter {
    func handle(push: AppPush) {
        guard self.isAdministrator else { return }
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
                let adminAction = sSelf.factory.adminAction(action: action, output: sSelf)
                sSelf.navigationController.raise(adminAction.viewController, animated: true)
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

extension AppPresenter: AddRoleModuleOutput {
    func addRole(module: AddRoleModule, didAddSupplier supplier: PCSupplier) {
        self.navigationController.popToRootViewController(animated: true)
    }

    func addRole(module: AddRoleModule, didAddOrganization organization: PCOrganization) {
        self.navigationController.popToRootViewController(animated: true)
    }

    func addRole(module: AddRoleModule, didAddMember member: PCMember) {
        self.navigationController.popToRootViewController(animated: true)
    }
}

extension AppPresenter: AdminActionModuleOutput {
    func adminAction(module: AdminActionModule, didApprove action: PCAction) {
        self.navigationController.unraise(animated: true)
    }

    func adminAction(module: AdminActionModule, didReject action: PCAction) {
        self.navigationController.unraise(animated: true)
    }
}

extension AppPresenter: OnboardModuleOutput {
    func onboard(module: OnboardModule, didLogin user: PCUser) {
        self.navigationController.setViewControllers([self.review.viewController], animated: true)
    }

    func onboard(module: OnboardModule, didRegister user: PCUser) {
        self.navigationController.setViewControllers([self.review.viewController], animated: true)
    }
}

extension AppPresenter: ReviewModuleOutput {
    func reviewUserWantsToLogout(module: ReviewModule) {
        self.logout()
    }

    func reviewUserWantsToAddRole(module: ReviewModule) {
        self.navigationController.pushViewController(self.addRole.viewController, animated: true)
    }

    func reviewUserWantsToEnterAdmin(module: ReviewModule) {
        self.navigationController.pushViewController(self.admin.viewController, animated: true)
    }

    func review(module: ReviewModule, userWantsToEnter organization: PCOrganization) {
        assert(organization.status == .approved)
        let organizationModule = self.organization(for: organization)
        self.navigationController.pushViewController(organizationModule.viewController, animated: true)
    }

    func review(module: ReviewModule, userWantsToEnter supplier: PCSupplier) {
        assert(supplier.status == .approved)
        let supplierModule = self.supplier(for: supplier)
        self.navigationController.pushViewController(supplierModule.viewController, animated: true)
    }

    func review(module: ReviewModule, userWantsToEnter member: PCMember) {
        assert(member.status == .approved)
        let memberModule = self.member(for: member)
        self.navigationController.pushViewController(memberModule.viewController, animated: true)
    }
}

extension AppPresenter: OrganizationModuleOutput {
    func organization(module: OrganizationModule, userWantsToOpenProfileOf organization: PCOrganization) {
        let organizationProfileModule = self.profile(for: organization)
        self.navigationController.pushViewController(organizationProfileModule.viewController, animated: true)
    }
    func organizationUserWantsToLogout(module: OrganizationModule) {
        self.logout()
    }
    func organizationUserWantsToChangeRole(module: OrganizationModule) {
        self.navigationController.popToViewController(self.review.viewController, animated: true)
    }
}

extension AppPresenter: SupplierModuleOutput {
    func supplier(module: SupplierModule, userWantsToOpenProfileOf supplier: PCSupplier) {
        let supplierProfileModule = self.profile(for: supplier)
        self.navigationController.pushViewController(supplierProfileModule.viewController, animated: true)
    }
    
    func supplierUserWantsToLogout(module: SupplierModule) {
        self.logout()
    }

    func supplierUserWantsToChangeRole(module: SupplierModule) {
        self.navigationController.popToViewController(self.review.viewController, animated: true)
    }
}

extension AppPresenter: MemberModuleOutput {
    func member(module: MemberModule, userWantsToOpenProfileOf member: PCMember) {
        let memberProfileModule = self.profile(for: member)
        self.navigationController.pushViewController(memberProfileModule.viewController, animated: true)
    }
    
    func memberUserWantsToLogout(module: MemberModule) {
        self.logout()
    }

    func memberUserWantsToChangeRole(module: MemberModule) {
        self.navigationController.popToViewController(self.review.viewController, animated: true)
    }
}

extension AppPresenter: MemberProfileModuleOutput {
    func memberProfile(module: MemberProfileModule, didUpdate member: PCMember) {
        self.weakMember?.member = member
    }
}

extension AppPresenter: OrganizationProfileModuleOutput {
    func organizationProfile(module: OrganizationProfileModule, didUpdate organization: PCOrganization) {
        self.weakOrganization?.organization = organization
    }
}

extension AppPresenter: SupplierProfileModuleOutput {
    func supplierProfile(module: SupplierProfileModule, didUpdate supplier: PCSupplier) {
        self.weakSupplier?.supplier = supplier
    }
}

extension AppPresenter: AdminModuleOutput {
    func adminUserWantsToLogout(module: AdminModule) {
        self.logout()
    }

    func adminUserWantsToChangeRole(module: AdminModule) {
        self.navigationController.popToViewController(self.review.viewController, animated: true)
    }
}

// MARK: - Private
extension AppPresenter {
    private func logout() {
        self.userService.logout { [weak self] result in
            guard let sSelf = self else { return }
            switch result {
            case .failure(let error):
                sSelf.errorPresenter.present(error)
            case .success:
                sSelf.navigationController.setViewControllers([sSelf.onboard.viewController], animated: true)
            }
        }
    }
}
