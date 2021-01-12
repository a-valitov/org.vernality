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

final class AdminCommercialOffersRouter {
    weak var main: MainModule?

    @discardableResult
    func embed(in tabBarController: UITabBarController, output: AdminCommercialOffersContainerViewOutput?) -> AdminCommercialOffersContainerViewInput {
        let commercialOffersContainer = AdminCommercialOffersContainerViewAlpha()
        commercialOffersContainer.output = output
        if var viewControllers = tabBarController.viewControllers {
            viewControllers.append(commercialOffersContainer)
            tabBarController.setViewControllers(viewControllers, animated: false)
        } else {
            tabBarController.setViewControllers([commercialOffersContainer], animated: false)
        }
        return commercialOffersContainer
    }

    func buildCommercialOffersApplications(output: AdminCommercialOffersApplicationsViewOutput?) -> UIViewController {
        let controller = AdminCommercialOffersApplicationsViewAlpha()
        controller.output = output
        return controller
    }

    func buildApprovedCommercialOffers(output: AdminApprovedCommercialOffersViewOutput?) -> UIViewController {
        let controller = AdminApprovedCommercialOffersViewAlpha()
        controller.output = output
        return controller
    }
}
