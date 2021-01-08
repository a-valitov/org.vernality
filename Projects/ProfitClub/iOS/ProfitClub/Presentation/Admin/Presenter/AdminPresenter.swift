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
import ConfirmationPresenter
import MenuPresenter
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
    private weak var adminOrganizationsModule: AdminOrganizationsModule?
    private weak var adminSuppliersModule: AdminSuppliersModule?
}

extension AdminPresenter: AdminTabBarViewOutput {
    func adminTabBar(view: AdminTabBarViewInput, tappenOn menuBarButton: Any) {
        let changeRole = MenuItem(title: "Сменить роль", image: #imageLiteral(resourceName: "refresh")) { [weak self] in
            guard let sSelf = self else { return }
            sSelf.output?.admin(module: sSelf, userWantsToChangeRole: sSelf.router?.main)
        }
        let logout = MenuItem(title: "Выйти", image: #imageLiteral(resourceName: "logout")) { [weak self] in
            guard let sSelf = self else { return }
            sSelf.presenters.confirmation.present(title: "Подтвердите выход", message: "Вы уверены что хотите выйти?", actionTitle: "Выйти", withCancelAction: true) { [weak sSelf] in
                guard let ssSelf = sSelf else { return }
                ssSelf.output?.admin(module: ssSelf, userWantsToLogoutInside: ssSelf.router?.main)
            }
        }
        self.presenters.menu.present(items: [changeRole, logout])
    }
}

extension AdminPresenter: AdminOrganizationsModuleOutput {
    func adminOrganizationsModuleDidLoad(module: AdminOrganizationsModule) {
        self.adminOrganizationsModule = module
    }

    func adminOrganizations(module: AdminOrganizationsModule, didSelect organization: PCOrganization) {
        self.router?.open(organization: organization, output: self)
    }
}

extension AdminPresenter: AdminOrganizationModuleOutput {
    func adminOrganization(module: AdminOrganizationModule, didApprove organization: PCOrganization) {
        self.adminOrganizationsModule?.onDidApprove(organization: organization)
    }

    func adminOrganization(module: AdminOrganizationModule, didReject organization: PCOrganization) {
        self.adminOrganizationsModule?.onDidReject(organization: organization)
    }
}

extension AdminPresenter: AdminCommercialOffersModuleOutput {
}

extension AdminPresenter: AdminSuppliersModuleOutput {
    func adminSuppliersModuleDidLoad(module: AdminSuppliersModule) {
        self.adminSuppliersModule = module
    }

    func adminSuppliers(module: AdminSuppliersModule, didSelect supplier: PCSupplier) {
        self.router?.open(supplier: supplier, output: self)
    }
}

extension AdminPresenter: AdminSupplierModuleOutput {
    func adminSupplier(module: AdminSupplierModule, didApprove supplier: PCSupplier) {
        self.adminSuppliersModule?.onDidApprove(supplier: supplier)
    }

    func adminSupplier(module: AdminSupplierModule, didReject supplier: PCSupplier) {
        self.adminSuppliersModule?.onDidReject(supplier: supplier)
    }
}

extension AdminPresenter: AdminActionsModuleOutput {
    
}
