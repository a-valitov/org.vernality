//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 20.10.2020
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
import PCActionService
import ErrorPresenter
import ActivityPresenter
import ConfirmationPresenter
import MenuPresenter
import PCCommercialOfferService
import PCUserService

public struct SupplierPresenters {
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

public struct SupplierServices {
    let user: PCUserService
    let action: PCActionService
    let commercialOffer: PCCommercialOfferService

    public init(
        user: PCUserService,
        action: PCActionService,
        commercialOffer: PCCommercialOfferService
    ) {
        self.user = user
        self.action = action
        self.commercialOffer = commercialOffer
    }
}
