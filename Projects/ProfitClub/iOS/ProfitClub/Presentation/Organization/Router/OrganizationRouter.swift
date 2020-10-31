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
import ProfitClubModel

final class OrganizationRouter {
    weak var main: MainModule?

    init(factories: OrganizationFactories) {
        self.factories = factories
    }

    @discardableResult
    func openOrganizationTabBar(output: OrganizationTabBarViewOutput & ActionsModuleOutput & CommercialOffersModuleOutput) -> OrganizationTabBarViewInput {
        let storyboard = UIStoryboard(name: "OrganizationTabBarViewBeta", bundle: nil)
        let organizationTabBar = storyboard.instantiateInitialViewController() as! OrganizationTabBarViewBeta
        organizationTabBar.output = output
        let actions = self.factories.actions.make(output: output)
        actions.embed(in: organizationTabBar, main: self.main)
        let commercialOffers = self.factories.commercialOffers.make(output: output)
        commercialOffers.embed(in: organizationTabBar, main: self.main)
        self.main?.push(organizationTabBar, animated: true)
        return organizationTabBar
    }

    @discardableResult
    func open(action: PCAction, output: ActionModuleOutput?) -> ActionModule {
        let actionModule = self.factories.action.make(action: action, output: output)
        actionModule.open(in: self.main)
        return actionModule
    }

    private let factories: OrganizationFactories
}
