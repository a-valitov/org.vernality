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
import ProfitClubModel

final class AdminRouter {
    weak var main: MainModule?

    init(factories: AdminFactories) {
        self.factories = factories
    }

    @discardableResult
    func openAdminTabBar(output: AdminTabBarViewOutput & AdminOrganizationsModuleOutput & AdminCommercialOffersModuleOutput & AdminSuppliersModuleOutput & AdminActionsModuleOutput) -> AdminTabBarViewInput {
        let adminTabBar = AdminTabBarViewAlpha()
        adminTabBar.output = output
        let applications = self.factories.adminOrganizations.make(output: output)
        applications.embed(in: adminTabBar, main: self.main)
        let adminCommercialOffers = self.factories.adminCommercialOffers.make(output: output)
        adminCommercialOffers.embed(in: adminTabBar, main: self.main)
        let adminSuppliers = self.factories.adminSuppliers.make(output: output)
        adminSuppliers.embed(in: adminTabBar, main: self.main)
        let adminActions = self.factories.adminActions.make(output: output)
        adminActions.embed(in: adminTabBar, main: self.main)
        self.main?.push(adminTabBar, animated: true)
        return adminTabBar
    }

    @discardableResult
    func open(organization: PCOrganization, output: AdminOrganizationModuleOutput?) -> AdminOrganizationModule {
        let organizationModule = self.factories.adminOrganization.make(organization: organization, output: output)
        organizationModule.open(in: self.main)
        return organizationModule
    }

    @discardableResult
    func open(supplier: PCSupplier, output: AdminSupplierModuleOutput?) -> AdminSupplierModule {
        let supplierModule = self.factories.adminSupplier.make(supplier: supplier, output: output)
        supplierModule.open(in: self.main)
        return supplierModule
    }

    private let factories: AdminFactories
}
