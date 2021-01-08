//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Macbook on 08.01.2021
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

protocol AdminActionApplicationViewInput: UIViewController {
    var actionImageUrl: URL? { get set }
    var actionMessage: String? { get set }
    var actionDescription: String? { get set }
    var organizationName: String? { get set }
    var actionLink: String? { get set }
    var actionStartDate: Date? { get set }
    var actionEndDate: Date? { get set }
}

protocol AdminActionApplicationViewOutput {
    func adminActionApplicationDidLoad(view: AdminActionApplicationViewInput)
    func adminActionApplication(view: AdminActionApplicationViewInput, userWantsToApprove sender: Any)
    func adminActionApplication(view: AdminActionApplicationViewInput, userWantsToReject sender: Any)
}
