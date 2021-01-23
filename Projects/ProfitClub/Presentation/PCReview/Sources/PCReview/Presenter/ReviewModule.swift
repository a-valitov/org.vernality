//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/30/20
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
import UIKit
import PCModel

public protocol ReviewModule: class {
    var viewController: UIViewController { get }
}

public protocol ReviewModuleOutput: class {
    func reviewUserWantsToLogout(module: ReviewModule)
    func reviewUserWantsToAddRole(module: ReviewModule)
    func reviewUserWantsToEnterAdmin(module: ReviewModule)
    func review(module: ReviewModule, userWantsToEnter organization: PCOrganization)
    func review(module: ReviewModule, userWantsToEnter supplier: PCSupplier)
    func review(module: ReviewModule, userWantsToEnter member: PCMember)
}
