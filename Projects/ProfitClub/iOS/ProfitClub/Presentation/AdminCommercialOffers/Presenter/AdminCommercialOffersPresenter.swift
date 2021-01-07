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
import Main
import ErrorPresenter
import ActivityPresenter
import ProfitClubModel

final class AdminCommercialOffersPresenter: AdminCommercialOffersModule {
    weak var output: AdminCommercialOffersModuleOutput?
    var router: AdminCommercialOffersRouter?

    init(presenters: AdminCommercialOffersPresenters,
         services: AdminCommercialOffersServices) {
        self.presenters = presenters
        self.services = services
    }

    func embed(in tabBarController: UITabBarController, main: MainModule?) {
        self.router?.main = main
        self.router?.embed(in: tabBarController, output: self)
    }

    // dependencies
    private let presenters: AdminCommercialOffersPresenters
    private let services: AdminCommercialOffersServices

    //submodules
    private weak var commercialOffersApplicationsView: AdminCommercialOffersApplicationsViewInput?
}

extension AdminCommercialOffersPresenter: AdminCommercialOffersContainerViewOutput {
    func adminCommercialOffersContainerDidLoad(view: AdminCommercialOffersContainerViewInput) {
        view.applications = router?.buildCommercialOffersApplications(output: self)
    }

    func adminCommercialOffersContainer(view: AdminCommercialOffersContainerViewInput, didChangeState state: AdminCommercialOffersContainerState) {
        view.state = state
    }
}

extension AdminCommercialOffersPresenter: AdminCommercialOffersApplicationsViewOutput {
    func adminCommercialOffersApplicationsDidLoad(view: AdminCommercialOffersApplicationsViewInput) {
        self.commercialOffersApplicationsView = view
        self.reloadCommercialOffersApplications()
    }

    func adminCommercialOffersApplications(view: AdminCommercialOffersApplicationsViewInput, userWantsToRefresh sender: Any) {
        self.commercialOffersApplicationsView = view
        self.reloadCommercialOffersApplications()
    }

}

extension AdminCommercialOffersPresenter {
    private func reloadCommercialOffersApplications() {
        self.services.commercialOffers.fetch(.onReview) { [weak self] (result) in
            switch result {
            case .success(let commercialOffers):
                self?.commercialOffersApplicationsView?.commercialOffers = commercialOffers
                self?.commercialOffersApplicationsView?.reload()
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }
}
