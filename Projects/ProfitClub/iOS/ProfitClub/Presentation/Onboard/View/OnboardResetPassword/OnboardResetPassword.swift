//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 14.11.2020
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

protocol OnboardResetPasswordViewInput: UIViewController {
    var email: String? { get }

    func alert()
    func finishAlert()
}

protocol OnboardResetPasswordViewOutput {
    func onboardResetPasswordDidFinish(view: OnboardResetPasswordViewInput)
    func onboardResetPasswordFinish(view: OnboardResetPasswordViewInput)
}
