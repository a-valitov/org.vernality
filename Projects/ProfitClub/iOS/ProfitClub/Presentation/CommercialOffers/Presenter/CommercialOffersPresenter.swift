//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 31.10.2020
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

final class CommercialOffersPresenter: CommercialOffersModule {
    weak var output: CommercialOffersModuleOutput?
    var router: CommercialOffersRouter?

    init(presenters: CommercialOffersPresenters,
         services: CommercialOffersServices) {
        self.presenters = presenters
        self.services = services
    }

    func embed(in tabBarController: UITabBarController, main: MainModule?) {
        self.router?.main = main
        self.router?.embed(in: tabBarController, output: self)
    }

    // dependencies
    private let presenters: CommercialOffersPresenters
    private let services: CommercialOffersServices
}

extension CommercialOffersPresenter: CommercialOffersViewOutput {
    func commercialOffersDidLoad(view: CommercialOffersViewInput) {
        self.services.commercialOffer.fetchApproved { [weak self] (result) in
            switch result {
            case .success(let commercialOffers):
                view.commercialOffers = commercialOffers
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }
}
