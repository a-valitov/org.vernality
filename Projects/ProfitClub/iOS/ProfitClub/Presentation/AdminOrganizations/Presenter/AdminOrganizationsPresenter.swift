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
import Main
import ErrorPresenter
import ActivityPresenter
import ProfitClubModel

final class AdminOrganizationsPresenter: AdminOrganizationsModule {
    weak var output: AdminOrganizationsModuleOutput?
    var router: AdminOrganizationsRouter?

    init(presenters: AdminOrganizationsPresenters,
         services: AdminOrganizationsServices) {
        self.presenters = presenters
        self.services = services
    }

    func embed(in tabBarController: UITabBarController, main: MainModule?) {
        self.router?.main = main
        self.router?.embed(in: tabBarController, output: self)
    }

    // dependencies
    private let presenters: AdminOrganizationsPresenters
    private let services: AdminOrganizationsServices
}

extension AdminOrganizationsPresenter: AdminOrganizationsContainerViewOutput {
    func adminOrganizationsContainerDidLoad(view: AdminOrganizationsContainerViewInput) {
        view.applications = router?.buildOrganizationApplications(output: self)
        view.approved = router?.buildApprovedOrganizations(output: self)
    }

    func adminOrganizationsContainer(view: AdminOrganizationsContainerViewInput, didChangeState state: AdminOrganizationsContainerState) {
        view.state = state
    }

}

extension AdminOrganizationsPresenter: AdminOrganizationsApplicationsViewOutput {
    func adminOrganizationsApplicationsViewDidLoad(view: AdminOrganizationsApplicationsViewInput) {
        self.services.organization.fetch(.onReview) { [weak self] (result) in
            switch result {
            case .success(let organizations):
                view.organizations = organizations.map({ $0.any })
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }
}

extension AdminOrganizationsPresenter: AdminApprovedOrganizationsViewOutput {
    func adminApprovedOrganizationsDidLoad(view: AdminApprovedOrganizationsViewInput) {

    }
}
