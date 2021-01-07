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
import Main
import ErrorPresenter
import ActivityPresenter
import ProfitClubModel

final class AdminSuppliersPresenter: AdminSuppliersModule {
    weak var output: AdminSuppliersModuleOutput?
    var router: AdminSuppliersRouter?

    init(presenters: AdminSuppliersPresenters,
         services: AdminSuppliersServices) {
        self.presenters = presenters
        self.services = services
    }

    func embed(in tabBarController: UITabBarController, main: MainModule?) {
        self.router?.main = main
        self.router?.embed(in: tabBarController, output: self)
    }

    func onDidApprove(supplier: PCSupplier) {
        suppliersApplicationsView?.hide(supplier: supplier)
        self.reloadApprovedSuppliers()
    }

    func onDidReject(supplier: PCSupplier) {
        suppliersApplicationsView?.hide(supplier: supplier)
    }

    // dependencies
    private let presenters: AdminSuppliersPresenters
    private let services: AdminSuppliersServices

    // submodules
    private weak var suppliersApplicationsView: AdminSuppliersApplicationsViewInput?
    private weak var approvedSuppliersView: AdminApprovedSuppliersViewInput?
}

extension AdminSuppliersPresenter: AdminSuppliersContainerViewOutput {
    func adminSuppliersContainerDidLoad(view: AdminSuppliersContainerViewInput) {
        view.applications = router?.buildSuppliersApplications(output: self)
        view.approved = router?.buildApprovedSuppliers(output: self)
        output?.adminSuppliersModuleDidLoad(module: self)
    }

    func adminSuppliersContainer(view: AdminSuppliersContainerViewInput, didChangeState state: AdminSuppliersContainerState) {
        view.state = state
    }
}

extension AdminSuppliersPresenter: AdminSuppliersApplicationsViewOutput {
    func adminSuppliersApplicationsViewDidLoad(view: AdminSuppliersApplicationsViewInput) {
        self.suppliersApplicationsView = view
        self.reloadSuppliersApplications()
    }

    func adminSuppliersApplications(view: AdminSuppliersApplicationsViewInput, userWantsToRefresh sender: Any) {
        self.suppliersApplicationsView = view
        self.reloadSuppliersApplications()
    }

    func adminSuppliersApplications(view: AdminSuppliersApplicationsViewInput, didSelect supplier: PCSupplier) {
        self.output?.adminSuppliers(module: self, didSelect: supplier)
    }
}

extension AdminSuppliersPresenter: AdminApprovedSuppliersViewOutput {
    func adminApprovedSuppliersDidLoad(view: AdminApprovedSuppliersViewInput) {
        self.approvedSuppliersView = view
        self.reloadApprovedSuppliers()
    }

    func adminApprovedSuppliers(view: AdminApprovedSuppliersViewInput, userWantsToRefresh sender: Any) {
        self.approvedSuppliersView = view
        self.reloadApprovedSuppliers()
    }
}

extension AdminSuppliersPresenter {
    private func reloadSuppliersApplications() {
        self.services.supplier.fetch(.onReview) { [weak self] (result) in
            switch result {
            case .success(let suppliers):
                self?.suppliersApplicationsView?.suppliers = suppliers
                self?.suppliersApplicationsView?.reload()
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }

    private func reloadApprovedSuppliers() {
        self.services.supplier.fetch(.approved) { [weak self] (result) in
            switch result {
            case .success(let suppliers):
                self?.approvedSuppliersView?.suppliers = suppliers
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }
}
