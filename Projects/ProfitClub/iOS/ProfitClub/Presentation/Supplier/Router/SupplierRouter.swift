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
        let storyboard = UIStoryboard(name: "SupplierViewBeta", bundle: nil)
        let supplierView = storyboard.instantiateInitialViewController() as! SupplierViewBeta
        supplierView.output = output
        self.main?.push(supplierView, animated: true)
        return supplierView
    }

    @discardableResult
    func openSupplierActions(output: SupplierActionsOutput?) -> SupplierActionsInput {
        let storyboard = UIStoryboard(name: "SupplierActionsBeta", bundle: nil)
        let supplierActions = storyboard.instantiateInitialViewController() as! SupplierActionsBeta
        supplierActions.output = output
        self.main?.push(supplierActions, animated: true)
        return supplierActions
    }

    @discardableResult
    func pop() {
        self.main?.pop()
    }

}

