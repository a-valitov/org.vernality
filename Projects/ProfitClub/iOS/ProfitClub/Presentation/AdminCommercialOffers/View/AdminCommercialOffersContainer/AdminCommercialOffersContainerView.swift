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

import UIKit

enum AdminCommercialOffersContainerState {
    case applications
    case approved
}

protocol AdminCommercialOffersContainerViewInput: UIViewController {
    var state: AdminCommercialOffersContainerState { get set }
    var applications: UIViewController? { get set }
    var approved: UIViewController? { get set }
}

protocol AdminCommercialOffersContainerViewOutput {
    func adminCommercialOffersContainerDidLoad(view: AdminCommercialOffersContainerViewInput)
    func adminCommercialOffersContainer(view: AdminCommercialOffersContainerViewInput, didChangeState state: AdminCommercialOffersContainerState)
}
