//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 17.11.2020
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
import ActivityPresenter
import ProfitClubModel

final class SupplierProfilePresenter: SupplierProfileModule {
    weak var output: SupplierProfileModuleOutput?
    var router: SupplierProfileRouter?

    init(supplier: PCSupplier,
         presenters: SupplierProfilePresenters,
         services: SupplierProfileServices) {
        self.supplier = supplier
        self.presenters = presenters
        self.services = services
    }

    func open(in main: MainModule?) {
        self.router?.main = main
        self.view = self.router?.openSupplierProfile(supplier: self.supplier, output: self)
    }

    private let presenters: SupplierProfilePresenters
    private let services: SupplierProfileServices

    // state
    private var supplier: PCSupplier
    private weak var view: SupplierProfileViewInput?
}

extension SupplierProfilePresenter: SupplierProfileViewOutput {
    func supplierProfile(view: SupplierProfileViewInput, userDidChangeImage image: UIImage) {
        self.presenters.activity.increment()
        self.services.supplier.editProfile(supplier: supplier, image: image) { [weak self] (result) in
            guard let sSelf = self else { return }
            sSelf.presenters.activity.decrement()
            switch result {
            case .success(let supplier):
                sSelf.supplier = supplier
                sSelf.view?.supplierImageUrl = supplier.imageUrl
                sSelf.output?.supplierProfile(module: sSelf, didUpdate: supplier)
            case .failure(let error):
                sSelf.presenters.error.present(error)
            }
        }
    }
}
