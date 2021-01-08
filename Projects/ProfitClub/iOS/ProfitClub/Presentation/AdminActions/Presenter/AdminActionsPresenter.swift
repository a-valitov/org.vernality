//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Macbook on 08.01.2021
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

final class AdminActionsPresenter: AdminActionsModule {
    weak var output: AdminActionsModuleOutput?
    var router: AdminActionsRouter?

    init(presenters: AdminActionsPresenters,
         services: AdminActionsServices) {
        self.presenters = presenters
        self.services = services
    }

    func embed(in tabBarController: UITabBarController, main: MainModule?) {
        self.router?.main = main
        self.router?.embed(in: tabBarController, output: self)
    }

    // dependencies
    private let presenters: AdminActionsPresenters
    private let services: AdminActionsServices
}

extension AdminActionsPresenter: AdminActionsContainerViewOutput {
    func adminActionsContainerDidLoad(view: AdminActionsContainerViewInput) {

    }

    func adminActionsContainer(view: AdminActionsContainerViewInput, didChangeState state: AdminActionsContainerState) {
        view.state = state
    }
}
