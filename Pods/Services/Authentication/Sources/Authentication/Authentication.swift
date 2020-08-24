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

import Foundation
import UserModel

public protocol Authentication {
    var user: AnyUser? { get }

    func login(email: String, password: String, result: @escaping (Result<AnyUser, Error>) -> Void)
    func register(email: String, password: String, result: @escaping (Result<Bool, Error>) -> Void)
    func logout(result: @escaping (Result<Bool, Error>) -> Void)
}
