//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Rinat Enikeev on 24.01.2021
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
import UIKit
import PCModel
import PCSupplierProfile

protocol SupplierProfileRouterDelegate: class {
    func supplierProfile(router: SupplierProfileRouter, didUpdate supplier: PCSupplier)
}

final class SupplierProfileRouter {
    var viewController: UIViewController {
        return self.supplierProfileModule.viewController
    }
    var navigationController: UINavigationController {
        if let navigationController = self.viewController.navigationController {
            return navigationController
        } else if let navigationController = self.weakNavigationController {
            return navigationController
        } else {
            let navigationController = UINavigationController(
                rootViewController: self.viewController
            )
            self.weakNavigationController = navigationController
            return navigationController
        }
    }
    weak var delegate: SupplierProfileRouterDelegate?

    init(user: PCUser, supplier: PCSupplier) {
        self.user = user
        self.supplier = supplier
    }

    private var supplierProfileModule: SupplierProfileModule {
        if let supplierProfileModule = self.weakSupplierProfileModule {
            return supplierProfileModule
        } else {
            let supplierProfileModule = self.supplierProfileFactory(
                user: self.user,
                supplier: self.supplier
            ).make(supplier: supplier, output: self)
            supplierProfileModule.router = self
            self.weakSupplierProfileModule = supplierProfileModule
            return supplierProfileModule
        }
    }
    private weak var weakSupplierProfileModule: SupplierProfileModule?

    private let user: PCUser
    private let supplier: PCSupplier
    private weak var weakNavigationController: UINavigationController?
}

// MARK: - ModuleOutput
extension SupplierProfileRouter: SupplierProfileModuleOutput {
    func supplierProfile(module: SupplierProfileModule,
                         didUpdate supplier: PCSupplier) {
        self.delegate?.supplierProfile(router: self, didUpdate: supplier)
    }
}

// MARK: - Factory
extension SupplierProfileRouter: Router {
    func supplierProfileFactory(user: PCUser, supplier: PCSupplier) -> SupplierProfileFactory {
        return SupplierProfileFactory(
            presenters: SupplierProfilePresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter()
            ),
            services: SupplierProfileServices(
                supplier: self.supplierService()
            )
        )
    }
}
