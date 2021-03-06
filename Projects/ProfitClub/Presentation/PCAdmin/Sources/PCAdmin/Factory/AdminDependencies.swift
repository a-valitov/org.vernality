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
import ErrorPresenter
import ActivityPresenter
import ConfirmationPresenter
import MenuPresenter
import PCUserService
import PCOrganizationService
import PCModel
import PCSupplierService
import PCActionService
import PCCommercialOfferService
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
#if canImport(PCUserServiceStub)
import PCUserServiceStub
#endif
#if canImport(PCSupplierServiceStub)
import PCSupplierServiceStub
#endif
#if canImport(PCActionServiceStub)
import PCActionServiceStub
#endif
#if canImport(PCCommercialOfferServiceStub)
import PCCommercialOfferServiceStub
#endif

public struct AdminPresenters {
    let error: ErrorPresenter
    let activity: ActivityPresenter
    let confirmation: ConfirmationPresenter
    let menu: MenuPresenter

    public init(
        error: ErrorPresenter,
        activity: ActivityPresenter,
        confirmation: ConfirmationPresenter,
        menu: MenuPresenter
    ) {
        self.error = error
        self.activity = activity
        self.confirmation = confirmation
        self.menu = menu
    }
}

public struct AdminServices {
    let userService: PCUserService

    public init(userService: PCUserService) {
        self.userService = userService
    }
}

public struct AdminFactories {
    let organizationService: PCOrganizationServiceFactory
    let user: PCUser

    public init(
        user: PCUser,
        organizationService: PCOrganizationServiceFactory
    ) {
        self.user = user
        self.organizationService = organizationService
    }

    var adminOrganizations: AdminOrganizationsFactory {
        return AdminOrganizationsFactory(
            presenters: AdminOrganizationsPresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter()
            ),
            services: AdminOrganizationsServices(
                user: self.userService(user: self.user)
            )
        )
    }

    var adminOrganization: AdminOrganizationFactory {
        return AdminOrganizationFactory(
            presenters: AdminOrganizationPresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter(),
                confirmation: self.confirmationPresenter()
            )
        )
    }

    var adminSuppliers: AdminSuppliersFactory {
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

    var adminSupplier: AdminSupplierFactory {
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

    var adminActions: AdminActionsFactory {
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

    var adminAction: AdminActionFactory {
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

    var adminCommercialOffers: AdminCommercialOffersFactory {
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

    var adminCommercialOffer: AdminCommercialOfferFactory {
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

    private func activityPresenter() -> ActivityPresenter {
        return ActivityPresenterCircleFactory().make()
    }

    private func errorPresenter() -> ErrorPresenter {
        return ErrorPresenterAlertFactory().make()
    }

    private func confirmationPresenter() -> ConfirmationPresenter {
        return ConfirmationPresenterAlertFactory().make()
    }

    private func menuPresenter() -> MenuPresenter {
        return MenuPresenterActionSheetFactory().make()
    }

    private func userService(user: PCUser) -> PCUserService {
        #if canImport(PCUserServiceStub)
        return PCUserServiceStubFactory(user: user).make()
        #else
        return PCUserServiceParseFactory(user: user).make()
        #endif

    }

    private func supplierService() -> PCSupplierService {
        #if canImport(PCSupplierServiceStub)
        return PCSupplierServiceStubFactory().make()
        #else
        return PCSupplierServiceParseFactory().make()
        #endif
    }

    private func actionService() -> PCActionService {
        #if canImport(PCActionServiceStub)
        return PCActionServiceStubFactory().make()
        #else
        return PCActionServiceParseFactory().make()
        #endif
    }

    private func commercialOfferService() -> PCCommercialOfferService {
        #if canImport(PCCommercialOfferServiceStub)
        return PCCommercialOfferServiceStubFactory().make()
        #else
        return PCCommercialOfferServiceParseFactory().make()
        #endif
    }
}
