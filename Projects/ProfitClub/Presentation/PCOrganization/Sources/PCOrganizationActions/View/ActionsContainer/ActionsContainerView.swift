//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 10/14/20
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

enum ActionsContainerState {
    case current
    case past
}

protocol ActionsContainerViewInput: UIViewController {
    var state: ActionsContainerState { get set }
    var current: UIViewController? { get set }
    var past: UIViewController? { get set }
}

protocol ActionsContainerViewOutput {
    func actionsContainerDidLoad(view: ActionsContainerViewInput)
    func actionsContainer(view: ActionsContainerViewInput, didChangeState state: ActionsContainerState)
}
