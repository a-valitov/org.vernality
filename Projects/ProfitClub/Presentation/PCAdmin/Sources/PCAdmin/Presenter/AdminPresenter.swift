//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 10.11.2020
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
import ErrorPresenter
import ActivityPresenter
import ConfirmationPresenter
import MenuPresenter
import PCModel
import Raise
#if canImport(PCAdminAction)
import PCAdminAction
#endif
#if canImport(PCAdminActions)
import PCAdminActions
#endif
#if canImport(PCAdminCommercialOffer)
import PCAdminCommercialOffer
#endif
#if canImport(PCAdminCommercialOffers)
import PCAdminCommercialOffers
#endif
#if canImport(PCAdminOrganization)
import PCAdminOrganization
#endif
#if canImport(PCAdminOrganizations)
import PCAdminOrganizations
#endif
#if canImport(PCAdminSupplier)
import PCAdminSupplier
#endif
#if canImport(PCAdminSuppliers)
import PCAdminSuppliers
#endif

final class AdminPresenter: AdminModule {
    weak var output: AdminModuleOutput?
    var router: AnyObject?
    var viewController: UIViewController {
        return self.admin
    }
    
    init(presenters: AdminPresenters,
         services: AdminServices,
         factories: AdminFactories) {
        self.presenters = presenters
        self.services = services
        self.factories = factories
    }

    func open(action: PCAction) {
        self.weakAdmin?.unraise(animated: true, completion: { [weak self] in
            guard let sSelf = self else { return }
            sSelf.weakAdmin?.selectedIndex = 0
            let adminAction = sSelf.factories.adminAction.make(action: action, output: sSelf)
            sSelf.weakAdmin?.raise(adminAction.viewController, animated: true)
        })
    }

    func open(commercialOffer: PCCommercialOffer) {
        self.weakAdmin?.unraise(animated: true, completion: { [weak self] in
            guard let sSelf = self else { return }
            sSelf.weakAdmin?.selectedIndex = 1
            let adminCommercialOffer = sSelf.factories.adminCommercialOffer.make(commercialOffer: commercialOffer, output: sSelf)
            sSelf.weakAdmin?.raise(adminCommercialOffer.viewController, animated: true)
        })
    }

    // views
    private var admin: UITabBarController {
        if let admin = self.weakAdmin {
            return admin
        } else {
            let admin = AdminTabBarViewAlpha()
            admin.output = self
            let adminActions = self.factories.adminActions.make(output: self)
            let adminCommercialOffers = self.factories.adminCommercialOffers.make(output: self)
            let adminOrganizations = self.factories.adminOrganizations.make(output: self)
            let adminSuppliers = self.factories.adminSuppliers.make(output: self)
            admin.viewControllers = [adminActions.viewController,
                                     adminCommercialOffers.viewController,
                                     adminOrganizations.viewController,
                                     adminSuppliers.viewController]
            self.weakAdmin = admin
            self.adminActions = adminActions
            self.adminCommercialOffers = adminCommercialOffers
            self.adminOrganizations = adminOrganizations
            self.adminSuppliers = adminSuppliers
            return admin
        }
    }
    private weak var weakAdmin: UITabBarController?

    // dependencies
    private let presenters: AdminPresenters
    private let services: AdminServices
    private let factories: AdminFactories

    // modules
    private weak var adminOrganizations: AdminOrganizationsModule?
    private weak var adminSuppliers: AdminSuppliersModule?
    private weak var adminActions: AdminActionsModule?
    private weak var adminCommercialOffers: AdminCommercialOffersModule?

    private var changeRoleImage: UIImage?
    private var logoutImage: UIImage?
}

extension AdminPresenter: AdminTabBarViewOutput {
    func adminTabBar(view: AdminTabBarViewInput, tappenOn menuBarButton: Any) {
        #if SWIFT_PACKAGE
        changeRoleImage = UIImage(named: "refresh", in: Bundle.module, compatibleWith: nil)
        #else
        changeRoleImage = UIImage(named: "refresh", in: Bundle(for: Self.self), compatibleWith: nil)
        #endif

        #if SWIFT_PACKAGE
        logoutImage = UIImage(named: "logout", in: Bundle.module, compatibleWith: nil)
        #else
        logoutImage = UIImage(named: "logout", in: Bundle(for: Self.self), compatibleWith: nil)
        #endif
        let changeRole = MenuItem(title: "Сменить роль", image: changeRoleImage) { [weak self] in
            guard let sSelf = self else { return }
            sSelf.output?.adminUserWantsToChangeRole(module: sSelf)
        }
        let logout = MenuItem(title: "Выйти", image: logoutImage) { [weak self] in
            guard let sSelf = self else { return }
            sSelf.presenters.confirmation.present(
                title: "Подтвердите выход",
                message: "Вы уверены что хотите выйти?",
                actionTitle: "Выйти",
                withCancelAction: true) { [weak sSelf] in
                guard let ssSelf = sSelf else { return }
                ssSelf.services.userService.logout { [weak ssSelf] result in
                    guard let sssSelf = ssSelf else { return }
                    switch result {
                    case .success:
                        sssSelf.output?.adminUserDidLogout(module: sssSelf)
                    case .failure(let error):
                        sssSelf.presenters.error.present(error)
                    }
                }
            }
        }
        self.presenters.menu.present(items: [changeRole, logout])
    }
}

extension AdminPresenter: AdminOrganizationsModuleOutput {
    func adminOrganizationsModuleDidLoad(module: AdminOrganizationsModule) {
        // do nothing
    }

    func adminOrganizations(module: AdminOrganizationsModule, didSelect organization: PCOrganization) {
        let adminOrganization = self.factories.adminOrganization.make(
            organizationService: self.factories.organizationService.make(organization: organization),
            output: self
        )
        self.weakAdmin?.raise(adminOrganization.viewController, animated: true)
    }
}

extension AdminPresenter: AdminOrganizationModuleOutput {
    func adminOrganization(module: AdminOrganizationModule, didApprove organization: PCOrganization) {
        module.viewController.unraise(animated: true)
        self.adminOrganizations?.onDidApprove(organization: organization)
    }

    func adminOrganization(module: AdminOrganizationModule, didReject organization: PCOrganization) {
        module.viewController.unraise(animated: true)
        self.adminOrganizations?.onDidReject(organization: organization)
    }
}

extension AdminPresenter: AdminCommercialOffersModuleOutput {
    func adminCommercialOffersModuleDidLoad(module: AdminCommercialOffersModule) {
        // do nothing
    }

    func adminCommercialOffers(module: AdminCommercialOffersModule, didSelect commercialOffer: PCCommercialOffer) {
        let commercialOffer = self.factories.adminCommercialOffer.make(commercialOffer: commercialOffer, output: self)
        self.weakAdmin?.raise(commercialOffer.viewController, animated: true)
    }

}

extension AdminPresenter: AdminCommercialOfferModuleOutput {
    func adminCommercialOffer(module: AdminCommercialOfferModule, didApprove commercialOffer: PCCommercialOffer) {
        module.viewController.unraise(animated: true)
        self.adminCommercialOffers?.onDidApprove(commercialOffer: commercialOffer)
    }

    func adminCommercialOffer(module: AdminCommercialOfferModule, didReject commercialOffer: PCCommercialOffer) {
        module.viewController.unraise(animated: true)
        self.adminCommercialOffers?.onDidReject(commercialOffer: commercialOffer)
    }
}

extension AdminPresenter: AdminSuppliersModuleOutput {
    func adminSuppliersModuleDidLoad(module: AdminSuppliersModule) {
        // do nothing
    }

    func adminSuppliers(module: AdminSuppliersModule, didSelect supplier: PCSupplier) {
        let adminSupplier = self.factories.adminSupplier.make(supplier: supplier, output: self)
        self.weakAdmin?.raise(adminSupplier.viewController, animated: true)
    }
}

extension AdminPresenter: AdminSupplierModuleOutput {
    func adminSupplier(module: AdminSupplierModule, didApprove supplier: PCSupplier) {
        self.adminSuppliers?.onDidApprove(supplier: supplier)
        module.viewController.unraise(animated: true)
    }

    func adminSupplier(module: AdminSupplierModule, didReject supplier: PCSupplier) {
        self.adminSuppliers?.onDidReject(supplier: supplier)
        module.viewController.unraise(animated: true)
    }
}

extension AdminPresenter: AdminActionsModuleOutput {
    func adminActionsModuleDidLoad(module: AdminActionsModule) {
        // do nothing
    }

    func adminActions(module: AdminActionsModule, didSelect action: PCAction) {
        let adminAction = self.factories.adminAction.make(action: action, output: self)
        self.weakAdmin?.raise(adminAction.viewController, animated: true)
    }
}

extension AdminPresenter: AdminActionModuleOutput {
    func adminAction(module: AdminActionModule, didApprove action: PCAction) {
        self.adminActions?.onDidApprove(action: action)
        module.viewController.unraise(animated: true)
    }

    func adminAction(module: AdminActionModule, didReject action: PCAction) {
        self.adminActions?.onDidReject(action: action)
        module.viewController.unraise(animated: true)
    }
}
