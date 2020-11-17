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
import Main
import ActivityPresenter
import ProfitClubModel

final class SupplierProfilePresenter: SupplierProfileModule {
    weak var output: SupplierProfileModuleOutput?
    var router: SupplierProfileRouter?

    init(presenters: SupplierProfilePresenters,
         services: SupplierProfileServices) {
        self.presenters = presenters
        self.services = services
    }

    func open(in main: MainModule?) {
        self.router?.main = main
        self.router?.openSupplierProfile(output: self)
    }

    private let presenters: SupplierProfilePresenters
    private let services: SupplierProfileServices
}

extension SupplierProfilePresenter: SupplierProfileViewOutput {

}
