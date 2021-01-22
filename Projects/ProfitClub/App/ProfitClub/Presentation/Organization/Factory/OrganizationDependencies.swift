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
import PCAuthentication
import PCOrganizationService
import ErrorPresenter
import ActivityPresenter
import ConfirmationPresenter
import MenuPresenter

struct OrganizationPresenters {
    let error: ErrorPresenter
    let activity: ActivityPresenter
    let confirmation: ConfirmationPresenter
    let menu: MenuPresenter
}

struct OrganizationServices {
    let authentication: PCAuthentication
    let organization: PCOrganizationService
}

struct OrganizationFactories {
    let actions: ActionsFactory
    let action: ActionFactory
    let commercialOffers: CommercialOffersFactory
    let commercialOffer: CommercialOfferFactory
    let members: MembersFactory
}
