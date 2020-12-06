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
import ProfitClubModel

final class SupplierRouter {
    weak var main: MainModule?

    @discardableResult
    func openSupplierView(output: SupplierViewOutput?) -> SupplierViewInput {
        let supplierView = SupplierViewAlpha()
        supplierView.output = output
        self.main?.push(supplierView, animated: true)
        return supplierView
    }

    @discardableResult
    func openSupplierActions(output: SupplierActionsOutput?) -> SupplierActionsInput {
        let supplierActions = SupplierActionsViewAlpha()
        supplierActions.output = output
        self.main?.push(supplierActions, animated: true)
        return supplierActions
    }

    @discardableResult
    func openSupplierCommercialOffer(output: SupplierCommercialOfferOutput?) -> SupplierCommercialOfferInput {
        let supplierCommercialOffer = SupplierCommercialOfferViewAlpha()
        supplierCommercialOffer.output = output
        self.main?.push(supplierCommercialOffer, animated: true)
        return supplierCommercialOffer
    }

    func pop() {
        self.main?.pop()
    }

}

