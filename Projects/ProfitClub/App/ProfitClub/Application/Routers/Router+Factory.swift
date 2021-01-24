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

protocol Router {
}

extension Router {
    // services
    func organizationService() -> PCOrganizationService {
        return PCOrganizationServiceParse()
    }

    func userService(user: PCUser) -> PCUserService {
        return PCUserServiceParseFactory(user: user).make()
    }

    func supplierService() -> PCSupplierService {
        return PCSupplierServiceParse()
    }

    func actionService() -> PCActionService {
        return PCActionServiceParse()
    }

    func commercialOfferService() -> PCCommercialOfferService {
        return PCCommercialOfferServiceParse()
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

    func membersFactory() -> MembersFactory {
        return MembersFactory(
            presenters: MembersPresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter(),
                confirmation: self.confirmationPresenter()
            ),
            services: MembersServices(
                organization: self.organizationService()
            )
        )
    }

    func commercialOffersFactory() -> CommercialOffersFactory {
        return CommercialOffersFactory(
            presenters: CommercialOffersPresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter()
            ),
            services: CommercialOffersServices(
                commercialOffer: self.commercialOfferService()
            )
        )
    }

    func commercialOfferFactory() -> CommercialOfferFactory {
        return CommercialOfferFactory(
            presenters: CommercialOfferPresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter()
            ),
            services: CommercialOfferServices(
                commercialOffer: self.commercialOfferService()
            )
        )
    }

    func actionsFactory() -> ActionsFactory {
        return ActionsFactory(
            presenters: ActionsPresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter()
            ),
            services: ActionsServices(
                action: self.actionService()
            )
        )
    }

    func actionFactory() -> ActionFactory {
        return ActionFactory(
            presenters: ActionPresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter()
            ),
            services: ActionServices(
                action: self.actionService()
            )
        )
    }
}
