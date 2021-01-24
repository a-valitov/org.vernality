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

protocol AdminRouterDelegate: class {
    func adminUserDidLogout(router: AdminRouter)
    func adminUserWantsToChangeRole(router: AdminRouter)
}

final class AdminRouter {
    var viewController: UIViewController {
        return self.admin.viewController
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
    weak var delegate: AdminRouterDelegate?

    init(user: PCUser) {
        self.user = user
    }

    private var admin: AdminModule {
        if let admin = self.weakAdmin {
            return admin
        } else {
            let admin = self.adminFactory(user: self.user).make(output: self)
            self.weakAdmin = admin
            return admin
        }
    }
    private weak var weakAdmin: AdminModule?

    private let user: PCUser
    private weak var weakNavigationController: UINavigationController?
}

// MARK: - AdminModuleOutput
extension AdminRouter: AdminModuleOutput {
    func adminUserDidLogout(module: AdminModule) {
        self.delegate?.adminUserDidLogout(router: self)
    }

    func adminUserWantsToChangeRole(module: AdminModule) {
        self.delegate?.adminUserWantsToChangeRole(router: self)
    }
}

// MARK: - Factories
extension AdminRouter: Router {
    private func adminFactory(user: PCUser) -> AdminFactory {
        return AdminFactory(
            presenters: AdminPresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter(),
                confirmation: self.confirmationPresenter(),
                menu: self.menuPresenter()
            ),
            services: AdminServices(
                userService: self.userService(user: user)
            ),
            factories: AdminFactories(
                adminOrganizations: self.adminOrganizationsFactory,
                adminOrganization: self.adminOrganizationFactory,
                adminCommercialOffers: self.adminCommercialOffersFactory,
                adminCommercialOffer: self.adminCommercialOfferFactory,
                adminSuppliers: self.adminSuppliersFactory,
                adminSupplier: self.adminSupplierFactory,
                adminActions: self.adminActionsFactory,
                adminAction: self.adminActionFactory
            )
        )
    }

    private var adminOrganizationsFactory: AdminOrganizationsFactory {
        return AdminOrganizationsFactory(
            presenters: AdminOrganizationsPresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter()
            ),
            services: AdminOrganizationsServices(
                organization: self.organizationService()
            )
        )
    }

    private var adminOrganizationFactory: AdminOrganizationFactory {
        return AdminOrganizationFactory(
            presenters: AdminOrganizationPresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter(),
                confirmation: self.confirmationPresenter()
            ),
            services: AdminOrganizationServices(
                organization: self.organizationService()
            )
        )
    }

    private var adminSuppliersFactory: AdminSuppliersFactory {
        return AdminSuppliersFactory(
            presenters: AdminSuppliersPresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter()
            ),
            services: AdminSuppliersServices(
                supplier: self.supplierService()
            )
        )
    }

    private var adminSupplierFactory: AdminSupplierFactory {
        return AdminSupplierFactory(
            presenters: AdminSupplierPresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter(),
                confirmation: self.confirmationPresenter()
            ),
            services: AdminSupplierServices(
                supplier: self.supplierService()
            )
        )
    }

    private var adminActionsFactory: AdminActionsFactory {
        return AdminActionsFactory(
            presenters: AdminActionsPresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter()
            ),
            services: AdminActionsServices(
                action: self.actionService()
            )
        )
    }

    private var adminActionFactory: AdminActionFactory {
        return AdminActionFactory(
            presenters: AdminActionPresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter(),
                confirmation: self.confirmationPresenter()
            ),
            services: AdminActionServices(
                action: self.actionService()
            )
        )
    }

    private var adminCommercialOffersFactory: AdminCommercialOffersFactory {
        return AdminCommercialOffersFactory(
            presenters: AdminCommercialOffersPresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter()
            ),
            services: AdminCommercialOffersServices(
                commercialOffers: self.commercialOfferService()
            )
        )
    }

    private var adminCommercialOfferFactory: AdminCommercialOfferFactory {
        return AdminCommercialOfferFactory(
            presenters: AdminCommercialOfferPresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter(),
                confirmation: self.confirmationPresenter()
            ),
            services: AdminCommercialOfferServices(
                commercialOffer: self.commercialOfferService()
            )
        )
    }
}
