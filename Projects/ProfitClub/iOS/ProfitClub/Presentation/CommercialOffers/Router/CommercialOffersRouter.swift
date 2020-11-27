//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 31.10.2020
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

final class CommercialOffersRouter {
    weak var main: MainModule?

    @discardableResult
    func embed(in tabBarController: UITabBarController, output: CommercialOffersViewOutput?) -> CommercialOffersViewInput {
//        let storyboard = UIStoryboard(name: "CommercialOffersViewBeta", bundle: nil)
//        let commercialOffers = storyboard.instantiateInitialViewController() as! CommercialOffersViewBeta
        let commercialOffers = CommercialOffersViewAlpha()
        commercialOffers.output = output
        commercialOffers.tabBarItem = UITabBarItem(title: "Поставки", image: #imageLiteral(resourceName: "selectedCommercialOfferItem"), selectedImage: #imageLiteral(resourceName: "commercialOfferItem"))
        if var viewControllers = tabBarController.viewControllers {
            viewControllers.append(commercialOffers)
            tabBarController.setViewControllers(viewControllers, animated: false)
        } else {
            tabBarController.setViewControllers([commercialOffers], animated: false)
        }
        return commercialOffers
    }
}
