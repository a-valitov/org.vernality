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
import Main
import ErrorPresenter
import ActivityPresenter
import ProfitClubModel

final class AdminPresenter: AdminModule {
    weak var output: AdminModuleOutput?
    var router: AdminRouter?

    init(presenters: AdminPresenters,
         services: AdminServices) {
        self.presenters = presenters
        self.services = services
    }

    func open(in main: MainModule?) {
        self.router?.main = main
        self.router?.openAdminTabBar(output: self)
    }

    // dependencies
    private let presenters: AdminPresenters
    private let services: AdminServices
}

extension AdminPresenter: AdminTabBarViewOutput {
    func adminTabBar(view: AdminTabBarViewInput, userWantsToLogout sender: Any) {
        view.showLogoutConfirmationDialog()
    }

    func adminTabBar(view: AdminTabBarViewInput, userConfirmToLogout sender: Any) {
        self.output?.admin(module: self, userWantsToLogoutInside: self.router?.main)
    }

    func adminTabBar(view: AdminTabBarViewInput, userWantsToChangeRole sender: Any) {
        self.output?.admin(module: self, userWantsToChangeRole: self.router?.main)
    }

    
}

extension AdminPresenter: AdminOrganizationsModuleOutput {
    func adminOrganizations(module: AdminOrganizationsModule, didSelect organization: PCOrganization) {
        self.router?.open(organization: organization, output: self)
    }
}

extension AdminPresenter: AdminOrganizationModuleOutput {

}
