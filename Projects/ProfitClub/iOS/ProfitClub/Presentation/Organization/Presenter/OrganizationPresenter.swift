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

    init(organization: PCOrganization,
         presenters: OrganizationPresenters,
         services: OrganizationServices) {
        self.organization = organization
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

    // state
    private let organization: PCOrganization
}

extension OrganizationPresenter: OrganizationTabBarViewOutput {
    func organizationTabBar(view: OrganizationTabBarViewInput, tappedOn profile: Any) {
        self.output?.organization(module: self, userWantsToOpenProfileOf: self.organization, inside: self.router?.main)
    }

    func organizationTabBar(view: OrganizationTabBarViewInput, userWantsToLogout sender: Any) {
        view.showLogoutConfirmationDialog()
    }

    func organizationTabBar(view: OrganizationTabBarViewInput, userConfirmToLogout sender: Any) {
        self.output?.organization(module: self, userWantsToLogoutInside: self.router?.main)
    }

    func organizationTabBar(view: OrganizationTabBarViewInput, userWantsToChangeRole sender: Any) {
        self.output?.organization(module: self, userWantsToChangeRole: self.router?.main)
    }
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

extension OrganizationPresenter: MembersModuleOutput {
    
}
