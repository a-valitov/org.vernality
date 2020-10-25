//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 25.10.2020
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

final class ActionsRouter {
    weak var main: MainModule?

    @discardableResult
    func embed(in tabBarController: UITabBarController, output: ActionsContainerViewOutput?) -> ActionsContainerViewInput {
        let storyboard = UIStoryboard(name: "ActionsContainerViewBeta", bundle: nil)
        let actionsContainer = storyboard.instantiateInitialViewController() as! ActionsContainerViewBeta
        actionsContainer.output = output
        if var viewControllers = tabBarController.viewControllers {
            viewControllers.append(actionsContainer)
            tabBarController.setViewControllers(viewControllers, animated: false)
        } else {
            tabBarController.setViewControllers([actionsContainer], animated: false)
        }
        return actionsContainer
    }
}
