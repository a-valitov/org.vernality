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
        UINavigationBar.appearance().barStyle = .black
        window?.rootViewController = self.main.viewController
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

    private var isAdministrator: Bool {
        return self.userService.user?.roles?.contains(.administrator) ?? false
    }

    // modules

    private weak var organizationModule: OrganizationModule?
    private weak var supplierModule: SupplierModule?
    private weak var memberModule: MemberModule?

    // modules construction
    var main: MainModule {
        if let mainModule = self.weakMain {
            return mainModule
        } else {
            let mainModule = self.factory.main(output: self)
            self.weakMain = mainModule
            return mainModule
        }
    }

    var review: ReviewModule {
        if let reviewModule = self.weakReview {
            return reviewModule
        } else {
            let reviewModule = self.factory.review(output: self)
            self.weakReview = reviewModule
            return reviewModule
        }
    }

    // weak modules
    private weak var weakMain: MainModule?
    private weak var weakReview: ReviewModule?
}

// MARK: - Push Notifications handling
extension AppPresenter {
    func handle(push: AppPush) {
        guard self.isAdministrator else { return }
        switch push {
        case .actionCreated(let actionId):
            self.openAdminAction(actionId: actionId)
        }
    }

    private func openAdminAction(actionId: String) {
        let actionService = self.factory.actionService()
        actionService.fetch(actionId) { [weak self] result in
            switch result {
            case .success(let action):
                let adminAction = self?.factory.adminAction(action: action, output: self)
                adminAction?.open(in: self?.main)
            case .failure(let error):
                self?.errorPresenter.present(error)
            }
        }
    }
}

extension AppPresenter: AdminActionModuleOutput {
    func adminAction(module: AdminActionModule, didApprove action: PCAction) {
        self.main.unraise(animated: true)
    }

    func adminAction(module: AdminActionModule, didReject action: PCAction) {
        self.main.unraise(animated: true)
    }
}

extension AppPresenter: MainModuleOutput {
    func mainDidLoad(module: MainModule) {
        if self.isLoggedIn {
            self.main.push(self.review.viewController, animated: true)
        } else {
            let onboard = self.factory.onboard(output: self)
            onboard.start(in: module)
        }
    }
}

extension AppPresenter: OnboardModuleOutput {
    func onboard(module: OnboardModule, didAddSupplier supplier: PCSupplier, inside main: MainModule?) {
        self.main.push(self.review.viewController, animated: true)
    }

    func onboard(module: OnboardModule, didAddOrganization organization: PCOrganization, inside main: MainModule?) {
        self.main.push(self.review.viewController, animated: true)
    }

    func onboard(module: OnboardModule, didAddMember member: PCMember, inside main: MainModule?) {
        self.main.push(self.review.viewController, animated: true)
    }

    func onboard(module: OnboardModule, didLogin user: PCUser, inside main: MainModule?) {
        self.main.push(self.review.viewController, animated: true)
    }
}

extension AppPresenter: ReviewModuleOutput {
    func reviewUserWantsToLogout(module: ReviewModule) {
        self.userService.logout { [weak self] result in
            switch result {
            case .failure(let error):
                self?.errorPresenter.present(error)
            case .success:
                self?.main.unwindToRoot()
                let onboard = self?.factory.onboard(output: self)
                onboard?.start(in: self?.main)
            }
        }
    }

    func reviewUserWantsToAddRole(module: ReviewModule) {
        let onboard = self.factory.onboard(output: self)
        onboard.onboard(in: self.main)
    }

    func reviewUserWantsToEnterAdmin(module: ReviewModule) {
        let admin = self.factory.admin(output: self)
        admin.open(in: self.main)
    }

    func review(module: ReviewModule, userWantsToEnter organization: PCOrganization) {
        assert(organization.status == .approved)
        let organizationModule = self.factory.organization(organization, output: self)
        organizationModule.open(in: self.main)
        self.organizationModule = organizationModule
    }

    func review(module: ReviewModule, userWantsToEnter supplier: PCSupplier) {
        assert(supplier.status == .approved)
        let supplierModule = self.factory.supplier(supplier: supplier, output: self)
        supplierModule.open(in: self.main)
        self.supplierModule = supplierModule
    }

    func review(module: ReviewModule, userWantsToEnter member: PCMember) {
        assert(member.status == .approved)
        let memberModule = self.factory.member(member: member, output: self)
        memberModule.open(in: self.main)
        self.memberModule = memberModule
    }
}

extension AppPresenter: OrganizationModuleOutput {
    func organization(module: OrganizationModule, userWantsToOpenProfileOf organization: PCOrganization, inside main: MainModule?) {
        let profile = self.factory.organizationProfile(organization: organization, output: self)
        profile.open(in: main)
    }

    func organization(module: OrganizationModule, userWantsToLogoutInside main: MainModule?) {
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

    func organization(module: OrganizationModule, userWantsToChangeRole main: MainModule?) {
        main?.unwindToRoot()
        self.main.push(self.review.viewController, animated: true)
    }
}

extension AppPresenter: SupplierModuleOutput {
    func supplier(module: SupplierModule, userWantsToLogoutInside main: MainModule?) {
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

    func supplier(module: SupplierModule, userWantsToOpenProfileOf supplier: PCSupplier, inside main: MainModule?) {
        let profile = self.factory.supplierProfile(supplier: supplier, output: self)
        profile.open(in: main)
    }

    func supplier(module: SupplierModule, userWantsToChangeRole main: MainModule?) {
        main?.unwindToRoot()
        self.main.push(self.review.viewController, animated: true)
    }
}

extension AppPresenter: MemberModuleOutput {
    func member(module: MemberModule, userWantsToOpenProfileOf member: PCMember, inside main: MainModule? ) {
        let profile = self.factory.memberProfile(member: member, output: self)
        profile.open(in: main)
    }

    func member(module: MemberModule, userWantsToLogoutInside main: MainModule?) {
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

    func member(module: MemberModule, userWantsToChangeRole main: MainModule?) {
        main?.unwindToRoot()
        self.main.push(self.review.viewController, animated: true)
    }
}

extension AppPresenter: MemberProfileModuleOutput {
    func memberProfile(module: MemberProfileModule, didUpdate member: PCMember) {
        self.memberModule?.member = member
    }
}

extension AppPresenter: OrganizationProfileModuleOutput {
    func organizationProfile(module: OrganizationProfileModule, didUpdate organization: PCOrganization) {
        self.organizationModule?.organization = organization
    }
}

extension AppPresenter: SupplierProfileModuleOutput {
    func supplierProfile(module: SupplierProfileModule, didUpdate supplier: PCSupplier) {
        self.supplierModule?.supplier = supplier
    }
}

extension AppPresenter: AdminModuleOutput {
    func admin(module: AdminModule, userWantsToLogoutInside main: MainModule?) {
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

    func admin(module: AdminModule, userWantsToChangeRole main: MainModule?) {
        main?.unwindToRoot()
        self.main.push(self.review.viewController, animated: true)
    }
}
