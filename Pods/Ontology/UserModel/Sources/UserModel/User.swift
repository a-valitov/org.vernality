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

public protocol User {
    var id: String { get }
    var email: String? { get }
}

public extension User {
    var any: AnyUser {
        return AnyUser(object: self)
    }
}

public struct UserStruct: User {
    public var id: String
    public var email: String?

    public init(id: String, email: String?) {
        self.id = id
        self.email = email
    }
}

public struct AnyUser: User, Equatable, Hashable {
    var object: User

    public var id: String {
        return self.object.id
    }

    public var email: String? {
        return self.object.email
    }

    public static func == (lhs: AnyUser, rhs: AnyUser) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
