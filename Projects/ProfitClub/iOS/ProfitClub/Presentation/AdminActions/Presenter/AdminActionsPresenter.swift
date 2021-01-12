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

    func onDidApprove(action: PCAction) {
        actionsApplicationsView?.hide(action: action)
        self.reloadApprovedActions()
    }

    func onDidReject(action: PCAction) {
        actionsApplicationsView?.hide(action: action)
    }

    // dependencies
    private let presenters: AdminActionsPresenters
    private let services: AdminActionsServices

    // submodule
    private weak var actionsApplicationsView: AdminActionsApplicationsViewInput?
    private weak var approvedActionsView: AdminApprovedActionsViewInput?
}

extension AdminActionsPresenter: AdminActionsContainerViewOutput {
    func adminActionsContainerDidLoad(view: AdminActionsContainerViewInput) {
        view.applications = router?.buildActionsApplications(output: self)
        view.approved = router?.buildApprovedActions(output: self)
        output?.adminActionsModuleDidLoad(module: self)
    }

    func adminActionsContainer(view: AdminActionsContainerViewInput, didChangeState state: AdminActionsContainerState) {
        view.state = state
    }
}

extension AdminActionsPresenter: AdminActionsApplicationsViewOutput {
    func adminActionsApplicationsDidLoad(view: AdminActionsApplicationsViewInput) {
        self.actionsApplicationsView = view
        self.reloadActionsApplications()
    }

    func adminActionsApplications(view: AdminActionsApplicationsViewInput, userWantsToRefresh sender: Any) {
        self.actionsApplicationsView = view
        self.reloadActionsApplications()
    }

    func adminActionsApplications(view: AdminActionsApplicationsViewInput, didSelect action: PCAction) {
        self.output?.adminActions(module: self, didSelect: action)
    }
}

extension AdminActionsPresenter: AdminApprovedActionsViewOutput {
    func adminApprovedActionsDidLoad(view: AdminApprovedActionsViewInput) {
        self.approvedActionsView = view
        self.reloadApprovedActions()
    }

    func adminApprovedActions(view: AdminApprovedActionsViewInput, userWantsToRefresh sender: Any) {
        self.approvedActionsView = view
        self.reloadApprovedActions()
    }
}

extension AdminActionsPresenter {
    private func reloadActionsApplications() {
        self.services.action.fetch(.onReview) { [weak self] (result) in
            switch result {
            case .success(let actions):
                self?.actionsApplicationsView?.actions = actions
                self?.actionsApplicationsView?.reload()
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }

    private func reloadApprovedActions() {
        self.services.action.fetch(.approved) { [weak self] (result) in
            switch result {
            case .success(let actions):
                self?.approvedActionsView?.actions = actions
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }
}
