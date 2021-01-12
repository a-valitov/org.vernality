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
import ProfitClubModel

final class AdminSuppliersRouter {
    weak var main: MainModule?

    @discardableResult
    func embed(in tabBarController: UITabBarController, output: AdminSuppliersContainerViewOutput?) -> AdminSuppliersContainerViewInput {
        let suppliersContainer = AdminSuppliersContainerViewAlpha()
        suppliersContainer.output = output
        if var viewControllers = tabBarController.viewControllers {
            viewControllers.append(suppliersContainer)
            tabBarController.setViewControllers(viewControllers, animated: false)
        } else {
            tabBarController.setViewControllers([suppliersContainer], animated: false)
        }
        return suppliersContainer
    }

    func buildSuppliersApplications(output: AdminSuppliersApplicationsViewOutput?) -> UIViewController {
        let controller = AdminSuppliersApplicationsViewAlpha()
        controller.output = output
        return controller
    }

    func buildApprovedSuppliers(output: AdminApprovedSuppliersViewOutput?) -> UIViewController {
        let controller = AdminApprovedSuppliersViewAlpha()
        controller.output = output
        return controller
    }
}