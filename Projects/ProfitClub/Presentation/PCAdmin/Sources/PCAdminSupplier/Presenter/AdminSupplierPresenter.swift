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
import ConfirmationPresenter
import PCModel

final class AdminSupplierPresenter: AdminSupplierModule {
    weak var output: AdminSupplierModuleOutput?
    var viewController: UIViewController {
        return self.adminSupplier
    }

    init(supplier: PCSupplier,
         presenters: AdminSupplierPresenters,
         services: AdminSupplierServices) {
        self.supplier = supplier
        self.presenters = presenters
        self.services = services
    }

    private let supplier: PCSupplier

    // dependencies
    private let presenters: AdminSupplierPresenters
    private let services: AdminSupplierServices

    // view
    private var adminSupplier: UIViewController {
        if let adminSupplier = self.weakAdminSupplier {
            return adminSupplier
        } else {
            let adminSupplier = AdminSupplierApplicationViewAlpha()
            adminSupplier.output = self
            self.weakAdminSupplier = adminSupplier
            return adminSupplier
        }
    }
    private weak var weakAdminSupplier: UIViewController?
}

extension AdminSupplierPresenter: AdminSupplierApplicationViewOutput {
    func adminSupplierApplicationDidLoad(view: AdminSupplierApplicationViewInput) {
        view.supplierName = self.supplier.name
        view.supplierINN = self.supplier.inn
        view.supplierContactName = self.supplier.contact
        view.supplierPhoneNumber = self.supplier.phone
        view.supplierImageUrl = self.supplier.imageUrl
    }

    func adminSupplierApplication(view: AdminSupplierApplicationViewInput, userWantsToApprove sender: Any) {
        self.presenters.confirmation.present(title: "Одобрить заявку?", message: "Одобрить заявку на создание поставщика \(view.supplierName ?? "")", actionTitle: "Одобрить", withCancelAction: true) { [weak self] in
            guard let supplier = self?.supplier else { return }
            self?.services.supplier.approve(supplier: supplier, result: { [weak self] (result) in
                guard let sSelf = self else { return }
                switch result {
                case .success(let supplier):
                    sSelf.output?.adminSupplier(module: sSelf, didApprove: supplier)
                case .failure(let error):
                    sSelf.presenters.error.present(error)
                }
            })
        }
    }

    func adminSupplierApplication(view: AdminSupplierApplicationViewInput, userWantsToReject sender: Any) {
        self.presenters.confirmation.present(title: "Отклонить заявку?", message: "Отклонить заявку на создание поставщика \(view.supplierName ?? "")", actionTitle: "Отклонить", withCancelAction: true) { [weak self] in
            guard let supplier = self?.supplier else { return }
            self?.services.supplier.reject(supplier: supplier, result: { [weak self] (result) in
                guard let sSelf = self else { return }
                switch result {
                case .success(let supplier):
                    sSelf.output?.adminSupplier(module: sSelf, didReject: supplier)
                case .failure(let error):
                    sSelf.presenters.error.present(error)
                }
            })
        }
    }

}
