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
import ErrorPresenter
import ConfirmationPresenter
import ActivityPresenter
import MenuPresenter
import PCUserService
import PCOrganizationService
import PCSupplierService
import PCActionService
import PCCommercialOfferService
import PCModel
import PCOrganization
import PCAuthentication

protocol Router {
}

extension Router {
    // factories
    var organizationService: PCOrganizationServiceFactory {
        return PCOrganizationServiceParseFactory()
    }

    // services
    func authenticationService() -> PCAuthentication {
        return PCAuthenticationParseFactory().make()
    }
    
    func organizationService(organization: PCOrganization) -> PCOrganizationService {
        return self.organizationService.make(organization: organization)
    }

    func userService(user: PCUser) -> PCUserService {
        return PCUserServiceParseFactory(user: user).make()
    }

    func supplierService() -> PCSupplierService {
        return PCSupplierServiceParseFactory().make()
    }

    func actionService() -> PCActionService {
        return PCActionServiceParseFactory().make()
    }

    func commercialOfferService() -> PCCommercialOfferService {
        return PCCommercialOfferServiceParseFactory().make()
    }

    // presenters
    func activityPresenter() -> ActivityPresenter {
        return ActivityPresenterCircleFactory().make()
    }

    func errorPresenter() -> ErrorPresenter {
        return ErrorPresenterAlertFactory().make()
    }

    func confirmationPresenter() -> ConfirmationPresenter {
        return ConfirmationPresenterAlertFactory().make()
    }

    func menuPresenter() -> MenuPresenter {
        return MenuPresenterActionSheetFactory().make()
    }
}
