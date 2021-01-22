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
import UIKit
import ErrorPresenter
import ActivityPresenter
import PCModel

final class ActionsPresenter: ActionsModule {
    weak var output: ActionsModuleOutput?
    var viewController: UIViewController {
        return self.container
    }

    init(presenters: ActionsPresenters,
         services: ActionsServices) {
        self.presenters = presenters
        self.services = services
    }

    // dependencies
    private let presenters: ActionsPresenters
    private let services: ActionsServices

    // views
    private var container: UIViewController {
        if let container = self.weakContainer {
            return container
        } else {
            let container = ActionsContainerViewAlpha()
            container.output = self
            self.weakContainer = container
            return container
        }
    }
    private var currentActions: UIViewController {
        if let currentActions = self.weakCurrentActions {
            return currentActions
        } else {
            let currentActions = CurrentActionsViewAlpha()
            currentActions.output = self
            self.weakCurrentActions = currentActions
            return currentActions
        }
    }
    private var pastActions: UIViewController {
        if let pastActions = self.weakPastActions {
            return pastActions
        } else {
            let pastActions = PastActionsViewAlpha()
            pastActions.output = self
            self.weakPastActions = pastActions
            return pastActions
        }
    }
    private func pastAction(action: PCAction) -> UIViewController {
        if let pastAction = self.weakPastAction {
            return pastAction
        } else {
            let pastAction = PastActionViewAlpha()
            pastAction.output = self
            pastAction.organizationName = action.supplier?.name
            pastAction.pastActionImageUrl = action.imageUrl
            pastAction.pastActionMessage = action.message
            pastAction.pastActionDescription = action.descriptionOf
            pastAction.pastActionStartDate = action.startDate
            pastAction.pastActionEndDate = action.endDate
            self.weakPastAction = pastAction
            return pastAction
        }
    }

    private weak var weakContainer: UIViewController?
    private weak var weakCurrentActions: UIViewController?
    private weak var weakPastActions: UIViewController?
    private weak var weakPastAction: UIViewController?
}

extension ActionsPresenter: ActionsContainerViewOutput {
    func actionsContainerDidLoad(view: ActionsContainerViewInput) {
        view.current = self.currentActions
        view.past = self.pastActions
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

    func currentActions(view: CurrentActionsViewInput, userWantsToRefresh sender: Any) {
        self.services.action.fetchApprovedCurrentActions { [weak self] (result) in
            switch result {
            case .success(let actions):
                view.actions = actions
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
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

    func pastActions(view: PastActionsViewInput, didSelect pastAction: PCAction) {
        let viewController = self.pastAction(action: pastAction)
        view.raise(viewController, animated: true)
    }

    func pastActions(view: PastActionsViewInput, userWantsToRefresh sender: Any) {
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

extension ActionsPresenter: PastActionViewOutput {

}
