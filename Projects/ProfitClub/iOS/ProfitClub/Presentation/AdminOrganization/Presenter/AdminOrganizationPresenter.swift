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

final class AdminOrganizationPresenter: AdminOrganizationModule {
    weak var output: AdminOrganizationModuleOutput?
    var router: AdminOrganizationRouter?

    init(organization: PCOrganization,
         presenters: AdminOrganizationPresenters,
         services: AdminOrganizationServices) {
        self.organization = organization
        self.presenters = presenters
        self.services = services
    }

    func open(in main: MainModule?) {
        self.router?.main = main
        self.router?.openApplication(output: self)
    }

    private let organization: PCOrganization

    // dependencies
    private let presenters: AdminOrganizationPresenters
    private let services: AdminOrganizationServices
}

extension AdminOrganizationPresenter: OrganizationApplicationViewOutput {
    func organizationApplicationDidLoad(view: OrganizationApplicationViewInput) {
        view.organizationName = self.organization.name
        view.organizationINN = self.organization.inn
        view.organizationContactName = self.organization.contact
        view.organizationPhoneNumber = self.organization.phone
    }

    func organizationApplication(view: OrganizationApplicationViewInput, userWantsToApprove sender: Any) {
        // TODO: @temur add confirmation
        self.router?.closeApplication(view, completion: { [weak self] in
            guard let organization = self?.organization else { return }
            self?.services.organization.approve(organization: organization) { [weak self] (result) in
                switch result {
                case .success(let organization):
                    print("TODO: @temur hide application and reload approved")
                case .failure(let error):
                    self?.presenters.error.present(error)
                }
            }
        })
    }

    func organizationApplication(view: OrganizationApplicationViewInput, userWantsToReject sender: Any) {
        // TODO: @temur add confirmation
        self.router?.closeApplication(view, completion: { [weak self] in
            guard let organization = self?.organization else { return }
            self?.services.organization.reject(organization: organization) { [weak self] (result) in
                switch result {
                case .success(let organization):
                    print("TODO: @temur hide application")
                case .failure(let error):
                    self?.presenters.error.present(error)
                }
            }
        })
    }
}
