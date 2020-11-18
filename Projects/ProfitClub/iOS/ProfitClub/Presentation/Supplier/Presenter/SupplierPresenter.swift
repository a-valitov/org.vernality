//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 20.10.2020
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

final class SupplierPresenter: SupplierModule {
    weak var output: SupplierModuleOutput?
    var router: SupplierRouter?

    init(supplier: PCSupplier,
         presenters: SupplierPresenters,
         services: SupplierServices) {
        self.supplier = supplier
        self.presenters = presenters
        self.services = services
    }

    func open(in main: MainModule?) {
        self.router?.main = main
        self.router?.openSupplierView(output: self)
    }

    // state
    private let supplier: PCSupplier

    // dependencies
    private let presenters: SupplierPresenters
    private let services: SupplierServices
}

extension SupplierPresenter: SupplierViewOutput {
    func supplierView(view: SupplierViewInput, supplierWantsToCreateAction sender: Any) {
        self.router?.openSupplierActions(output: self)
    }

    func supplier(view: SupplierViewInput, wantsToCreateCommercialOffer sender: Any) {
        self.router?.openSupplierCommercialOffer(output: self)
    }

    func supplierNavigationBar(view: SupplierViewInput, tappedOn profile: Any) {
        self.output?.supplier(module: self, userWantsToEnterProfileInside: self.router?.main)
    }

    func supplier(view: SupplierViewInput, userWantsToLogout sender: Any) {
        view.showLogoutConfirmationDialog()
    }

    func supplier(view: SupplierViewInput, userConfirmToLogout sender: Any) {
        self.output?.supplier(module: self, userWantsToLogoutInside: self.router?.main)
    }

    func supplier(view: SupplierViewInput, userWantsToChangeRole sender: Any) {
        self.output?.supplier(module: self, userWantsToChangeRole: self.router?.main)
    }
}

extension SupplierPresenter: SupplierActionsOutput {
    func supplierNavigationBar(view: SupplierActionsInput, tappedOn profile: Any) {
        self.output?.supplier(module: self, userWantsToEnterProfileInside: self.router?.main)
    }

    func supplierActionsDidFinish(view: SupplierActionsInput) {
        guard let message = view.message, !message.isEmpty else {
            self.presenters.error.present(SupplierError.actionMessageIsEmpty)
            return
        }
        guard let descriptionOf = view.descriptionOf, !descriptionOf.isEmpty else {
            self.presenters.error.present(SupplierError.actionDescriptionOfIsEmpty)
            return
        }
        guard let link = view.link, !link.isEmpty else {
            self.presenters.error.present(SupplierError.actionLinkIsEmpty)
            return
        }
        guard let image = view.image else {
            self.presenters.error.present(SupplierError.actionImageIsNil)
            return
        }
        guard let startDate = view.startDate else {
            self.presenters.error.present(SupplierError.actionStartDateIsEmpty)
            return
        }
        guard let endDate = view.endDate else {
            self.presenters.error.present(SupplierError.actionEndDateIsEmpty)
            return
        }

        var action = PCActionStruct()
        action.message = message
        action.descriptionOf = descriptionOf
        action.link = link
        action.image = image
        action.startDate = startDate
        action.endDate = endDate
        action.status = .onReview
        action.supplier = self.supplier

        self.presenters.activity.increment()
        self.services.action.add(action: action) { [weak self] result in
            self?.presenters.activity.decrement()
            switch result {
            case .success:
                self?.router?.pop()
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }

    func supplierActions(view: SupplierActionsInput, userWantsToLogout sender: Any) {
        view.showLogoutConfirmationDialog()
    }

    func supplierActions(view: SupplierActionsInput, userConfirmLogout sender: Any) {
        self.output?.supplier(module: self, userWantsToLogoutInside: self.router?.main)
    }

    func supplierActions(view: SupplierActionsInput, userWantsToChangeRole sender: Any) {
        self.output?.supplier(module: self, userWantsToChangeRole: self.router?.main)
    }
}

extension SupplierPresenter: SupplierCommercialOfferOutput {
    func supplierNavigationBar(view: SupplierCommercialOfferInput, tappedOn profile: Any) {
        self.output?.supplier(module: self, userWantsToEnterProfileInside: self.router?.main)
    }
    
    func supplierCommercialOfferDidFinish(view: SupplierCommercialOfferInput) {
        guard let message = view.message, !message.isEmpty else {
            self.presenters.error.present(SupplierError.actionMessageIsEmpty)
            return
        }
        var offer = PCCommercialOfferStruct()
        offer.message = message
        offer.image = view.image
        offer.supplier = self.supplier
        offer.attachments = view.attachments
        offer.attachmentNames = view.attachmentNames
        
        self.presenters.activity.increment()
        self.services.commercialOffer.add(offer: offer) { [weak self] result in
            self?.presenters.activity.decrement()
            switch result {
            case .success:
                self?.router?.pop()
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }

    func supplierCommercialOffer(view: SupplierCommercialOfferInput, userWantsToLogout sender: Any) {
        view.showLogoutConfirmationDialog()
    }

    func supplierCommercialOffer(view: SupplierCommercialOfferInput, userConfirmToLogout sender: Any) {
        self.output?.supplier(module: self, userWantsToLogoutInside: self.router?.main)
    }

    func supplierCommercialOffer(view: SupplierCommercialOfferInput, userWantsToChangeRole sender: Any) {
        self.output?.supplier(module: self, userWantsToChangeRole: self.router?.main)
    }
}
