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
import Main
import ErrorPresenter
import ActivityPresenter
import ProfitClubModel

final class OrganizationPresenter: OrganizationModule {
    weak var output: OrganizationModuleOutput?
    var router: OrganizationRouter?

    init(presenters: OrganizationPresenters,
         services: OrganizationServices) {
        self.presenters = presenters
        self.services = services
    }

    func open(in main: MainModule?) {
        self.router?.main = main
        self.router?.openOrganizationTabBar(output: self)
    }

    // dependencies
    private let presenters: OrganizationPresenters
    private let services: OrganizationServices
}

extension OrganizationPresenter: OrganizationTabBarViewOutput {
    
}

extension OrganizationPresenter: ActionsModuleOutput {
    func actions(module: ActionsModule, didSelect action: PCAction) {
        self.router?.open(action: action, output: self)
    }
}

extension OrganizationPresenter: ActionModuleOutput {

}

extension OrganizationPresenter: CommercialOffersModuleOutput {
    func commercialOffers(module: CommercialOffersModule, didSelect commercialOffer: PCCommercialOffer) {
        self.router?.open(commercialOffer: commercialOffer, output: self)
    }
}

extension OrganizationPresenter: CommercialOfferModuleOutput {
    
}
