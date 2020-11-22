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
import ErrorPresenter
import ActivityPresenter
import ProfitClubModel

final class ActionsPresenter: ActionsModule {
    weak var output: ActionsModuleOutput?
    var router: ActionsRouter?

    init(presenters: ActionsPresenters,
         services: ActionsServices) {
        self.presenters = presenters
        self.services = services
    }

    func embed(in tabBarController: UITabBarController, main: MainModule?) {
        self.router?.main = main
        self.router?.embed(in: tabBarController, output: self)
    }

    // dependencies
    private let presenters: ActionsPresenters
    private let services: ActionsServices
}

extension ActionsPresenter: ActionsContainerViewOutput {
    func actionsContainerDidLoad(view: ActionsContainerViewInput) {
        view.current = router?.buildCurrentActions(output: self)
        view.past = router?.buildPastActions(output: self)
    }

    func actionsContainer(view: ActionsContainerViewInput, didChangeState state: ActionsContainerState) {
        view.state = state
    }
}

extension ActionsPresenter: CurrentActionsViewOutput {
    func currentActionsDidLoad(view: CurrentActionsViewInput) {
        self.services.action.fetchApprovedCurrentActions { [weak self] (result) in
            switch result {
            case .success(let actions):
                view.actions = actions
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }

    func currentActions(view: CurrentActionsViewInput, didSelect action: PCAction) {
        self.output?.actions(module: self, didSelect: action)
    }
}

extension ActionsPresenter: PastActionsViewOutput {
    func pastActionsDidLoad(view: PastActionsViewInput) {
        self.services.action.fetchApprovedPastActions { [weak self] (result) in
            switch result {
            case .success(let actions):
                view.actions = actions
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }
}
