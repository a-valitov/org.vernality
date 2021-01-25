//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Macbook on 07.01.2021
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

public final class AdminCommercialOffersFactory {
    public init(presenters: AdminCommercialOffersPresenters,
         services: AdminCommercialOffersServices) {
        self.presenters = presenters
        self.services = services
    }

    public func make(output: AdminCommercialOffersModuleOutput?) -> AdminCommercialOffersModule {
        let presenter = AdminCommercialOffersPresenter(presenters: self.presenters,
                                                       services: self.services)
        presenter.output = output
        return presenter
    }

    private let services: AdminCommercialOffersServices
    private let presenters: AdminCommercialOffersPresenters
}
