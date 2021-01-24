//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 10.11.2020
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

final class AdminOrganizationsPresenter: AdminOrganizationsModule {
    weak var output: AdminOrganizationsModuleOutput?
    var viewController: UIViewController {
        return self.adminOrganizationsContainer
    }
    
    init(presenters: AdminOrganizationsPresenters,
         services: AdminOrganizationsServices) {
        self.presenters = presenters
        self.services = services
    }

    func onDidApprove(organization: PCOrganization) {
        self.weakAdminOrganizationsApplications?.hide(organization: organization)
        self.reloadApprovedOrganizations()
    }

    func onDidReject(organization: PCOrganization) {
        self.weakAdminOrganizationsApplications?.hide(organization: organization)
    }

    // dependencies
    private let presenters: AdminOrganizationsPresenters
    private let services: AdminOrganizationsServices

    // views
    private var adminOrganizationsContainer: UIViewController {
        if let adminOrganizationsContainer = self.weakAdminOrganizationsContainer {
            return adminOrganizationsContainer
        } else {
            let adminOrganizationsContainer = AdminOrganizationsContainerViewAlpha()
            adminOrganizationsContainer.output = self
            self.weakAdminOrganizationsContainer = adminOrganizationsContainer
            return adminOrganizationsContainer
        }
    }
    private var adminOrganizationsApplications: AdminOrganizationsApplicationsViewInput {
        if let adminOrganizationsApplications = self.weakAdminOrganizationsApplications {
            return adminOrganizationsApplications
        } else {
            let adminOrganizationsApplications = AdminOrganizationsApplicationsViewAlpha()
            adminOrganizationsApplications.output = self
            self.weakAdminOrganizationsApplications = adminOrganizationsApplications
            return adminOrganizationsApplications
        }
    }
    private var adminApprovedOrganizations: AdminApprovedOrganizationsViewInput {
        if let adminApprovedOrganizations = self.weakAdminApprovedOrganizations {
            return adminApprovedOrganizations
        } else {
            let adminApprovedOrganizations = AdminApprovedOrganizationsViewAlpha()
            adminApprovedOrganizations.output = self
            self.weakAdminApprovedOrganizations = adminApprovedOrganizations
            return adminApprovedOrganizations
        }
    }

    private weak var weakAdminOrganizationsContainer: UIViewController?
    private weak var weakAdminOrganizationsApplications: AdminOrganizationsApplicationsViewInput?
    private weak var weakAdminApprovedOrganizations: AdminApprovedOrganizationsViewInput?
}

extension AdminOrganizationsPresenter: AdminOrganizationsContainerViewOutput {
    func adminOrganizationsContainerDidLoad(view: AdminOrganizationsContainerViewInput) {
        view.applications = self.adminOrganizationsApplications
        view.approved = self.adminApprovedOrganizations
        self.output?.adminOrganizationsModuleDidLoad(module: self)
    }

    func adminOrganizationsContainer(
        view: AdminOrganizationsContainerViewInput,
        didChangeState state: AdminOrganizationsContainerState
    ) {
        view.state = state
    }

}

extension AdminOrganizationsPresenter: AdminOrganizationsApplicationsViewOutput {
    func adminOrganizationsApplicationsViewDidLoad(
        view: AdminOrganizationsApplicationsViewInput
    ) {
        self.reloadApplicationsOrganizations()
    }

    func adminOrganizationsApplications(
        view: AdminOrganizationsApplicationsViewInput,
        didSelect organization: PCOrganization
    ) {
        self.output?.adminOrganizations(module: self, didSelect: organization)
    }

    func adminOrganizationsApplications(
        view: AdminOrganizationsApplicationsViewInput,
        userWantsToRefresh sender: Any
    ) {
        self.reloadApplicationsOrganizations()
    }
}

extension AdminOrganizationsPresenter: AdminApprovedOrganizationsViewOutput {
    func adminApprovedOrganizationsDidLoad(
        view: AdminApprovedOrganizationsViewInput
    ) {
        self.reloadApprovedOrganizations()
    }

    func adminApprovedOrganizations(
        view: AdminApprovedOrganizationsViewInput, userWantsToRefresh sender: Any
    ) {
        self.reloadApprovedOrganizations()
    }
}

extension AdminOrganizationsPresenter {
    private func reloadApprovedOrganizations() {
        self.services.user.fetch(.approved) { [weak self] (result) in
            switch result {
            case .success(let organizations):
                self?.weakAdminApprovedOrganizations?.organizations = organizations
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }

    private func reloadApplicationsOrganizations() {
        self.services.user.fetch(.onReview) { [weak self] (result) in
            switch result {
            case .success(let organizations):
                self?.weakAdminOrganizationsApplications?.organizations = organizations
                self?.weakAdminOrganizationsApplications?.reload()
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }
}
