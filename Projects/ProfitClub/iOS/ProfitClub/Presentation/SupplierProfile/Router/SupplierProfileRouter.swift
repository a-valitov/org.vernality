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
import ProfitClubModel

final class SupplierProfileRouter {
    weak var main: MainModule?

    @discardableResult
    func openSupplierProfile(supplier: PCSupplier, output: SupplierProfileViewOutput?) -> SupplierProfileViewInput {
        let profile = SupplierProfileViewAlpha()
        profile.output = output
        profile.email = supplier.owner?.email
        profile.supplierName = supplier.name
        profile.supplierINN = supplier.inn
        profile.supplierContactName = supplier.contact
        profile.supplierPhoneNumber = supplier.phone
        profile.supplierImageUrl = supplier.imageUrl
        self.main?.push(profile, animated: true)
        return profile
    }
}
