//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Macbook on 07.01.2021
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

final class AdminCommercialOffersPresenter: AdminCommercialOffersModule {
    weak var output: AdminCommercialOffersModuleOutput?
    var viewController: UIViewController {
        return self.commercialOffersContainer
    }

    init(presenters: AdminCommercialOffersPresenters,
         services: AdminCommercialOffersServices) {
        self.presenters = presenters
        self.services = services
    }

    func onDidApprove(commercialOffer: PCCommercialOffer) {
        self.weakCommercialOffersApplications?.hide(commercialOffer: commercialOffer)
        self.reloadApprovedCommercialOffers()
    }

    func onDidReject(commercialOffer: PCCommercialOffer) {
        self.weakCommercialOffersApplications?.hide(commercialOffer: commercialOffer)
    }

    // dependencies
    private let presenters: AdminCommercialOffersPresenters
    private let services: AdminCommercialOffersServices

    //submodules
    private var commercialOffersContainer: UIViewController {
        if let commercialOffersContainer = self.weakCommercialOffersContainer {
            return commercialOffersContainer
        } else {
            let commercialOffersContainer = AdminCommercialOffersContainerViewAlpha()
            commercialOffersContainer.output = self
            self.weakCommercialOffersContainer = commercialOffersContainer
            return commercialOffersContainer
        }
    }
    private var commercialOffersApplications: AdminCommercialOffersApplicationsViewInput {
        if let commercialOffersApplications = self.weakCommercialOffersApplications {
            return commercialOffersApplications
        } else {
            let commercialOffersApplications = AdminCommercialOffersApplicationsViewAlpha()
            commercialOffersApplications.output = self
            self.weakCommercialOffersApplications = commercialOffersApplications
            return commercialOffersApplications
        }
    }
    private var approvedCommercialOffers: AdminApprovedCommercialOffersViewInput {
        if let approvedCommercialOffers = self.weakApprovedCommercialOffers {
            return approvedCommercialOffers
        } else {
            let approvedCommercialOffers = AdminApprovedCommercialOffersViewAlpha()
            approvedCommercialOffers.output = self
            self.weakApprovedCommercialOffers = approvedCommercialOffers
            return approvedCommercialOffers
        }
    }

    private weak var weakCommercialOffersContainer: UIViewController?
    private weak var weakCommercialOffersApplications: AdminCommercialOffersApplicationsViewInput?
    private weak var weakApprovedCommercialOffers: AdminApprovedCommercialOffersViewInput?
}

extension AdminCommercialOffersPresenter: AdminCommercialOffersContainerViewOutput {
    func adminCommercialOffersContainerDidLoad(view: AdminCommercialOffersContainerViewInput) {
        view.applications = self.commercialOffersApplications
        view.approved = self.approvedCommercialOffers
        self.output?.adminCommercialOffersModuleDidLoad(module: self)
    }

    func adminCommercialOffersContainer(view: AdminCommercialOffersContainerViewInput, didChangeState state: AdminCommercialOffersContainerState) {
        view.state = state
    }
}

extension AdminCommercialOffersPresenter: AdminCommercialOffersApplicationsViewOutput {
    func adminCommercialOffersApplicationsDidLoad(view: AdminCommercialOffersApplicationsViewInput) {
        self.reloadCommercialOffersApplications()
    }

    func adminCommercialOffersApplications(view: AdminCommercialOffersApplicationsViewInput, userWantsToRefresh sender: Any) {
        self.reloadCommercialOffersApplications()
    }

    func adminCommercialOffersApplications(view: AdminCommercialOffersApplicationsViewInput, didSelect commercialOffer: PCCommercialOffer) {
        self.output?.adminCommercialOffers(module: self, didSelect: commercialOffer)
    }
}

extension AdminCommercialOffersPresenter: AdminApprovedCommercialOffersViewOutput {
    func adminApprovedCommercialOffersDidLoad(view: AdminApprovedCommercialOffersViewInput) {
        self.reloadApprovedCommercialOffers()
    }

    func adminApprovedCommercialOffers(view: AdminApprovedCommercialOffersViewInput, userWantsToRefresh sender: Any) {
        self.reloadApprovedCommercialOffers()
    }
}

extension AdminCommercialOffersPresenter {
    private func reloadCommercialOffersApplications() {
        self.services.commercialOffers.fetch(.onReview) { [weak self] (result) in
            switch result {
            case .success(let commercialOffers):
                self?.weakCommercialOffersApplications?.commercialOffers = commercialOffers
                self?.weakCommercialOffersApplications?.reload()
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }

    private func reloadApprovedCommercialOffers() {
        self.services.commercialOffers.fetch(.approved) { [weak self] (result) in
            switch result {
            case .success(let commercialOffers):
                self?.weakApprovedCommercialOffers?.commercialOffers = commercialOffers
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }
}
