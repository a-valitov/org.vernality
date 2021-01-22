//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 17.11.2020
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
import ActivityPresenter
import ProfitClubModel

final class OrganizationProfilePresenter: OrganizationProfileModule {
    weak var output: OrganizationProfileModuleOutput?
    var viewController: UIViewController {
        return self.view
    }

    init(organization: PCOrganization,
         presenters: OrganizationProfilePresenters,
         services: OrganizationProfileServices) {
        self.organization = organization
        self.presenters = presenters
        self.services = services
    }


    // dependencies
    private let presenters: OrganizationProfilePresenters
    private let services: OrganizationProfileServices

    // state
    private var organization: PCOrganization

    // view
    private var view: UIViewController {
        if let view = self.weakView {
            return view
        } else {
            let view = OrganizationProfileViewAlpha()
            view.output = self
            view.email = self.organization.owner?.email
            view.organizationName = self.organization.name
            view.organizationINN = self.organization.inn
            view.organizationContactName = self.organization.contact
            view.organizationPhoneNumber = self.organization.phone
            view.organizationImageUrl = self.organization.imageUrl
            self.weakView = view
            return view
        }
    }
    private weak var weakView: OrganizationProfileViewInput?
}

extension OrganizationProfilePresenter: OrganizationProfileViewOutput {
    func organizationProfile(view: OrganizationProfileViewInput, userDidChangeImage image: UIImage) {
        self.presenters.activity.increment()
        self.services.organization.editProfile(organization: organization, image: image) { [weak self] (result) in
            guard let sSelf = self else { return }
            sSelf.presenters.activity.decrement()
            switch result {
            case .success(let organization):
                sSelf.organization = organization
                sSelf.weakView?.organizationImageUrl = organization.imageUrl
                sSelf.output?.organizationProfile(module: sSelf, didUpdate: organization)
            case .failure(let error):
                sSelf.presenters.error.present(error)
            }
        }
    }
}
