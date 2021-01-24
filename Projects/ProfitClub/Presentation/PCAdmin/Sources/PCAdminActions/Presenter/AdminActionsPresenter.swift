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
import ErrorPresenter
import ActivityPresenter
import PCModel

final class AdminActionsPresenter: AdminActionsModule {
    weak var output: AdminActionsModuleOutput?
    var viewController: UIViewController {
        return self.adminActionsContainer
    }

    init(presenters: AdminActionsPresenters,
         services: AdminActionsServices) {
        self.presenters = presenters
        self.services = services
    }

    func onDidApprove(action: PCAction) {
        self.weakAdminActionsApplications?.hide(action: action)
        self.reloadApprovedActions()
    }

    func onDidReject(action: PCAction) {
        self.weakAdminActionsApplications?.hide(action: action)
    }

    // dependencies
    private let presenters: AdminActionsPresenters
    private let services: AdminActionsServices

    // submodule
    private var adminActionsContainer: UIViewController {
        if let adminActionsContainer = self.weakAdminActionsContainer {
            return adminActionsContainer
        } else {
            let adminActionsContainer = AdminActionsContainerViewAlpha()
            adminActionsContainer.output = self
            self.weakAdminActionsContainer = adminActionsContainer
            return adminActionsContainer
        }
    }
    private var adminActionsApplications: AdminActionsApplicationsViewInput {
        if let adminActionsApplications = self.weakAdminActionsApplications {
            return adminActionsApplications
        } else {
            let adminActionsApplications = AdminActionsApplicationsViewAlpha()
            adminActionsApplications.output = self
            self.weakAdminActionsApplications = adminActionsApplications
            return adminActionsApplications
        }
    }
    private var adminApprovedActions: AdminApprovedActionsViewInput {
        if let adminApprovedActions = self.weakAdminApprovedActions {
            return adminApprovedActions
        } else {
            let adminApprovedActions = AdminApprovedActionsViewAlpha()
            adminApprovedActions.output = self
            self.weakAdminApprovedActions = adminApprovedActions
            return adminApprovedActions
        }
    }
    private weak var weakAdminActionsContainer: AdminActionsContainerViewInput?
    private weak var weakAdminActionsApplications: AdminActionsApplicationsViewInput?
    private weak var weakAdminApprovedActions: AdminApprovedActionsViewInput?
}

extension AdminActionsPresenter: AdminActionsContainerViewOutput {
    func adminActionsContainerDidLoad(view: AdminActionsContainerViewInput) {
        view.applications = self.adminActionsApplications
        view.approved = self.adminApprovedActions
        self.output?.adminActionsModuleDidLoad(module: self)
    }

    func adminActionsContainer(view: AdminActionsContainerViewInput, didChangeState state: AdminActionsContainerState) {
        view.state = state
    }
}

extension AdminActionsPresenter: AdminActionsApplicationsViewOutput {
    func adminActionsApplicationsDidLoad(view: AdminActionsApplicationsViewInput) {
        self.reloadActionsApplications()
    }

    func adminActionsApplications(view: AdminActionsApplicationsViewInput, userWantsToRefresh sender: Any) {
        self.reloadActionsApplications()
    }

    func adminActionsApplications(view: AdminActionsApplicationsViewInput, didSelect action: PCAction) {
        self.output?.adminActions(module: self, didSelect: action)
    }
}

extension AdminActionsPresenter: AdminApprovedActionsViewOutput {
    func adminApprovedActionsDidLoad(view: AdminApprovedActionsViewInput) {
        self.reloadApprovedActions()
    }

    func adminApprovedActions(view: AdminApprovedActionsViewInput, userWantsToRefresh sender: Any) {
        self.reloadApprovedActions()
    }
}

extension AdminActionsPresenter {
    private func reloadActionsApplications() {
        self.services.action.fetch(.onReview) { [weak self] (result) in
            switch result {
            case .success(let actions):
                self?.weakAdminActionsApplications?.actions = actions
                self?.weakAdminActionsApplications?.reload()
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }

    private func reloadApprovedActions() {
        self.services.action.fetch(.approved) { [weak self] (result) in
            switch result {
            case .success(let actions):
                self?.weakAdminApprovedActions?.actions = actions
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }
}
