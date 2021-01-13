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

import UIKit

protocol OrganizationProfileViewInput: UIViewController {
    var organizationName: String? { get set }
    var organizationINN: String? { get set }
    var organizationContactName: String? { get set }
    var organizationPhoneNumber: String? { get set }
    var organizationImageUrl: URL? { get set }
    var organizationImage: UIImage? { get set }
    var email: String? { get set }
}

protocol OrganizationProfileViewOutput {
    func organizationProfile(view: OrganizationProfileViewInput, userWantsToEditProfile sender: Any)
}
