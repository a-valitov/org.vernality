//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/21/20
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

#if canImport(UIKit)
import Foundation

public protocol LoginViewInput: UIViewController {
    var email: String? { get set }
    var password: String? { get set }
    var parameters: [String: Any]? { get }
}

public protocol LoginViewOutput {
    func loginViewUserWantsToLogin(_ view: LoginViewInput)
    func loginViewUserWantsToRegister(_ view: LoginViewInput)
}

public protocol LoginViewFactory {
    func makeView(_ output: LoginViewOutput) -> LoginViewInput
}
#endif
