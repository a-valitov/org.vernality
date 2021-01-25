//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 10/14/20
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
import PCUserService
import PCOrganizationService
import ErrorPresenter
import ActivityPresenter
import ConfirmationPresenter
import MenuPresenter
import PCCommercialOfferService
import PCActionService
import PCModel

public struct OrganizationPresenters {
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

public struct OrganizationServices {
    let userService: PCUserService
    let organization: PCOrganizationService

    public init(
        userService: PCUserService,
        organization: PCOrganizationService
    ) {
        self.userService = userService
        self.organization = organization
    }
}

public struct OrganizationFactories {
    public init() {}
    
    var actions: ActionsFactory {
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

    var action: ActionFactory {
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

    var commercialOffers: CommercialOffersFactory {
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

    var commercialOffer: CommercialOfferFactory {
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

    func members(organizationService: PCOrganizationService) -> MembersFactory {
        return MembersFactory(
            presenters: MembersPresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter(),
                confirmation: self.confirmationPresenter()
            ),
            services: MembersServices(
                organization: organizationService
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

    private func actionService() -> PCActionService {
        return PCActionServiceParseFactory().make()
    }

    private func commercialOfferService() -> PCCommercialOfferService {
        return PCCommercialOfferServiceParseFactory().make()
    }
}
