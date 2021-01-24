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
import ConfirmationPresenter
import ActivityPresenter
import PCModel

final class AdminOrganizationPresenter: AdminOrganizationModule {
    weak var output: AdminOrganizationModuleOutput?
    var viewController: UIViewController {
        return self.adminOrganization
    }

    init(organization: PCOrganization,
         presenters: AdminOrganizationPresenters,
         services: AdminOrganizationServices) {
        self.organization = organization
        self.presenters = presenters
        self.services = services
    }

    private let organization: PCOrganization

    // dependencies
    private let presenters: AdminOrganizationPresenters
    private let services: AdminOrganizationServices

    // view
    private var adminOrganization: UIViewController {
        if let adminOrganization = self.weakAdminOrganization {
            return adminOrganization
        } else {
            let adminOrganization = OrganizationApplicationViewAlpha()
            adminOrganization.output = self
            self.weakAdminOrganization = adminOrganization
            return adminOrganization
        }
    }

    private weak var weakAdminOrganization: UIViewController?
}

extension AdminOrganizationPresenter: OrganizationApplicationViewOutput {
    func organizationApplicationDidLoad(view: OrganizationApplicationViewInput) {
        view.organizationName = self.organization.name
        view.organizationINN = self.organization.inn
        view.organizationContactName = self.organization.contact
        view.organizationPhoneNumber = self.organization.phone
        view.organizationImageUrl = self.organization.imageUrl
    }

    func organizationApplication(view: OrganizationApplicationViewInput, userWantsToApprove sender: Any) {
        self.presenters.confirmation.present(title: "Одобрить заявку?", message: "Одобрить заявку на создание организации \(view.organizationName ?? "")", actionTitle: "Одобрить", withCancelAction: true) { [weak self] in
            guard let organization = self?.organization else { return }
//            self?.services.organization.approve(organization: organization) { [weak self] (result) in
//                guard let sSelf = self else { return }
//                switch result {
//                case .success(let organization):
//                    sSelf.output?.adminOrganization(module: sSelf, didApprove: organization)
//                case .failure(let error):
//                    sSelf.presenters.error.present(error)
//                }
//            }
        }
    }

    func organizationApplication(view: OrganizationApplicationViewInput, userWantsToReject sender: Any) {
        self.presenters.confirmation.present(title: "Отклонить заявку?", message: "Отклонить заявку на создание организации \(view.organizationName ?? "")", actionTitle: "Отклонить", withCancelAction: true) { [weak self] in
            guard let organization = self?.organization else { return }
//            self?.services.organization.reject(organization: organization) { [weak self] (result) in
//                guard let sSelf = self else { return }
//                switch result {
//                case .success(let organization):
//                    sSelf.output?.adminOrganization(module: sSelf, didReject: organization)
//                case .failure(let error):
//                    sSelf.presenters.error.present(error)
//                }
//            }
        }
    }
}
