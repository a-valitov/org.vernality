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

    init(presenters: SupplierPresenters,
         services: SupplierServices) {
        self.presenters = presenters
        self.services = services
    }

    func open(in main: MainModule?) {
        self.router?.main = main
        self.router?.openSupplierView(output: self)
    }

    // dependencies
    private let presenters: SupplierPresenters
    private let services: SupplierServices

    // persisted
    private var actionMessage: String?
    private var actionDescriptionOf: String?
    private var actionLink: String?
}

extension SupplierPresenter: SupplierViewOutput {
    func supplierView(view: SupplierViewInput, supplierWantsToCreateAction sender: Any) {
        self.router?.openSupplierActions(output: self)
    }
}

extension SupplierPresenter: SupplierActionsOutput {
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
        self.actionMessage = message
        self.actionDescriptionOf = descriptionOf
        self.actionLink = link
        //        self.registerAction
    }

}

extension SupplierPresenter {
    private func createAction() -> PCActionStruct? {
        guard let message = self.actionMessage, !message.isEmpty else {
            self.presenters.error.present(SupplierError.actionMessageIsEmpty)
            return nil
        }
        guard let descriptionOf = self.actionDescriptionOf, !descriptionOf.isEmpty else {
            self.presenters.error.present(SupplierError.actionDescriptionOfIsEmpty)
            return nil
        }
        guard let link = self.actionLink, !link.isEmpty else {
            self.presenters.error.present(SupplierError.actionLinkIsEmpty)
            return nil
        }
        var action = PCActionStruct()
        action.message = message
        action.descriptionOf = descriptionOf
        action.link = link
        action.status = .onReview
        return action
    }

}
