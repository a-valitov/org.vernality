//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 10.11.2020
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

enum AdminOrganizationsContainerState {
    case applications
    case approved
}

protocol AdminOrganizationsContainerViewInput: UIViewController {
    var state: AdminOrganizationsContainerState { get set }
    var applications: UIViewController? { get set }
    var approved: UIViewController? { get set }
}

protocol AdminOrganizationsContainerViewOutput {
    func adminOrganizationsContainerDidLoad(view: AdminOrganizationsContainerViewInput)
    func adminOrganizationsContainer(view: AdminOrganizationsContainerViewInput, didChangeState state: AdminOrganizationsContainerState)
}
