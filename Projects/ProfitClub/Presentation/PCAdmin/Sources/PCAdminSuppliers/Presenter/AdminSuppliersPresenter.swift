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
import PCModel

final class AdminSuppliersPresenter: AdminSuppliersModule {
    weak var output: AdminSuppliersModuleOutput?
    var viewController: UIViewController {
        return self.suppliersContainer
    }

    init(presenters: AdminSuppliersPresenters,
         services: AdminSuppliersServices) {
        self.presenters = presenters
        self.services = services
    }

    func onDidApprove(supplier: PCSupplier) {
        self.weakSuppliersApplications?.hide(supplier: supplier)
        self.reloadApprovedSuppliers()
    }

    func onDidReject(supplier: PCSupplier) {
        self.weakSuppliersApplications?.hide(supplier: supplier)
    }

    // dependencies
    private let presenters: AdminSuppliersPresenters
    private let services: AdminSuppliersServices

    // submodules
    private var suppliersContainer: UIViewController {
        if let suppliersContainer = self.weakSuppliersContainer {
            return suppliersContainer
        } else {
            let suppliersContainer = AdminSuppliersContainerViewAlpha()
            suppliersContainer.output = self
            self.weakSuppliersContainer = suppliersContainer
            return suppliersContainer
        }
    }
    private var suppliersApplications: AdminSuppliersApplicationsViewInput {
        if let suppliersApplications = self.weakSuppliersApplications {
            return suppliersApplications
        } else {
            let suppliersApplications = AdminSuppliersApplicationsViewAlpha()
            suppliersApplications.output = self
            self.weakSuppliersApplications = suppliersApplications
            return suppliersApplications
        }
    }
    private var approvedSuppliers: AdminApprovedSuppliersViewInput {
        if let approvedSuppliers = self.weakApprovedSuppliers {
            return approvedSuppliers
        } else {
            let approvedSuppliers = AdminApprovedSuppliersViewAlpha()
            approvedSuppliers.output = self
            self.weakApprovedSuppliers = approvedSuppliers
            return approvedSuppliers
        }
    }

    private weak var weakSuppliersContainer: UIViewController?
    private weak var weakSuppliersApplications: AdminSuppliersApplicationsViewInput?
    private weak var weakApprovedSuppliers: AdminApprovedSuppliersViewInput?
}

extension AdminSuppliersPresenter: AdminSuppliersContainerViewOutput {
    func adminSuppliersContainerDidLoad(view: AdminSuppliersContainerViewInput) {
        view.applications = self.suppliersApplications
        view.approved = self.approvedSuppliers
        self.output?.adminSuppliersModuleDidLoad(module: self)
    }

    func adminSuppliersContainer(view: AdminSuppliersContainerViewInput, didChangeState state: AdminSuppliersContainerState) {
        view.state = state
    }
}

extension AdminSuppliersPresenter: AdminSuppliersApplicationsViewOutput {
    func adminSuppliersApplicationsViewDidLoad(view: AdminSuppliersApplicationsViewInput) {
        self.reloadSuppliersApplications()
    }

    func adminSuppliersApplications(view: AdminSuppliersApplicationsViewInput, userWantsToRefresh sender: Any) {
        self.reloadSuppliersApplications()
    }

    func adminSuppliersApplications(view: AdminSuppliersApplicationsViewInput, didSelect supplier: PCSupplier) {
        self.output?.adminSuppliers(module: self, didSelect: supplier)
    }
}

extension AdminSuppliersPresenter: AdminApprovedSuppliersViewOutput {
    func adminApprovedSuppliersDidLoad(view: AdminApprovedSuppliersViewInput) {
        self.reloadApprovedSuppliers()
    }

    func adminApprovedSuppliers(view: AdminApprovedSuppliersViewInput, userWantsToRefresh sender: Any) {
        self.reloadApprovedSuppliers()
    }
}

extension AdminSuppliersPresenter {
    private func reloadSuppliersApplications() {
        self.services.supplier.fetch(.onReview) { [weak self] (result) in
            switch result {
            case .success(let suppliers):
                self?.weakSuppliersApplications?.suppliers = suppliers
                self?.weakSuppliersApplications?.reload()
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }

    private func reloadApprovedSuppliers() {
        self.services.supplier.fetch(.approved) { [weak self] (result) in
            switch result {
            case .success(let suppliers):
                self?.weakApprovedSuppliers?.suppliers = suppliers
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }
}
