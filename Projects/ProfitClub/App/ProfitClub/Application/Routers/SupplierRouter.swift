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
import PCSupplier

protocol SupplierRouterDelegate: class {
    func supplierUserDidLogout(router: SupplierRouter)
    func supplierUserWantsToChangeRole(router: SupplierRouter)
}

final class SupplierRouter {
    var viewController: UIViewController {
        return self.supplierModule.viewController
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
    weak var delegate: SupplierRouterDelegate?

    init(user: PCUser, supplier: PCSupplier) {
        self.user = user
        self.supplier = supplier
    }

    private var supplierModule: SupplierModule {
        if let supplierModule = self.weakSupplierModule {
            return supplierModule
        } else {
            let supplierModule = self.supplierFactory(
                user: self.user,
                supplier: self.supplier
            ).make(supplier: self.supplier, output: self)
            supplierModule.router = self
            self.weakSupplierModule = supplierModule
            return supplierModule
        }
    }
    private weak var weakSupplierModule: SupplierModule?

    private func supplierProfileRouter(supplier: PCSupplier) -> SupplierProfileRouter {
        if let supplierProfileRouter = self.weakSupplierProfileRouter {
            return supplierProfileRouter
        } else {
            let supplierProfileRouter = SupplierProfileRouter(
                user: self.user,
                supplier: supplier
            )
            supplierProfileRouter.delegate = self
            self.weakSupplierProfileRouter = supplierProfileRouter
            return supplierProfileRouter
        }
    }
    private weak var weakSupplierProfileRouter: SupplierProfileRouter?

    private let user: PCUser
    private let supplier: PCSupplier
    private weak var weakNavigationController: UINavigationController?
}

// MARK: - SupplierProfileRouterDelegate
extension SupplierRouter: SupplierProfileRouterDelegate {
    func supplierProfile(router: SupplierProfileRouter, didUpdate supplier: PCSupplier) {
        self.weakSupplierModule?.supplier = supplier
    }
}

// MARK: - ModuleOutput
extension SupplierRouter: SupplierModuleOutput {
    func supplier(module: SupplierModule,
                  userWantsToOpenProfileOf supplier: PCSupplier) {
        self.navigationController.pushViewController(
            self.supplierProfileRouter(supplier: supplier).viewController,
            animated: true
        )
    }

    func supplierUserDidLogout(module: SupplierModule) {
        self.delegate?.supplierUserDidLogout(router: self)
    }

    func supplierUserWantsToChangeRole(module: SupplierModule) {
        self.delegate?.supplierUserWantsToChangeRole(router: self)
    }
}

// MARK: - Factory
extension SupplierRouter: Router {
    func supplierFactory(user: PCUser, supplier: PCSupplier) -> SupplierFactory {
        return SupplierFactory(
            presenters: SupplierPresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter(),
                confirmation: self.confirmationPresenter(),
                menu: self.menuPresenter()
            ),
            services: SupplierServices(
                user: self.userService(user: user),
                action: self.actionService(),
                commercialOffer: self.commercialOfferService()
            )
        )
    }
}
