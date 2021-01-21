//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Macbook on 04.01.2021
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

public protocol ConfirmationPresenter {
    func present(title: String, message: String, actionTitle: String?, withCancelAction: Bool, completion: (() -> Void)?)
}

public extension ConfirmationPresenter {
    func present(title: String, message: String, actionTitle: String?, withCancelAction: Bool) {
        self.present(title: title, message: message, actionTitle: actionTitle, withCancelAction: withCancelAction, completion: nil)
    }
}

public protocol ConfirmationPresenterFactory {
    func make() -> ConfirmationPresenter
}
