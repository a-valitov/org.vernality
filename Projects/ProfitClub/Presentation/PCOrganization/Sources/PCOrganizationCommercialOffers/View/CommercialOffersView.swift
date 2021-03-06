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

import UIKit
import PCModel

protocol CommercialOffersViewInput: UIViewController {
    var commercialOffers: [AnyPCCommercialOffer] { get set }
}

protocol CommercialOffersViewOutput {
    func commercialOffersDidLoad(view: CommercialOffersViewInput)
    func commercialOffers(view: CommercialOffersViewInput, didSelect commercialOffer: PCCommercialOffer)
    func commercialOffers(view: CommercialOffersViewInput, userWantsToRefresh sender: Any)
}
