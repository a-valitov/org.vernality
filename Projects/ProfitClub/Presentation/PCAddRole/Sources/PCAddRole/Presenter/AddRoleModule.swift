//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Rinat Enikeev on 18.01.2021
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

public protocol AddRoleModule: class {
    var viewController: UIViewController { get }
    var router: AnyObject? { get set }
}

public protocol AddRoleModuleOutput: class {
    func addRole(module: AddRoleModule, didAddSupplier supplier: PCSupplier)
    func addRole(module: AddRoleModule, didAddOrganization organization: PCOrganization)
    func addRole(module: AddRoleModule, didAddMember member: PCMember)
}
