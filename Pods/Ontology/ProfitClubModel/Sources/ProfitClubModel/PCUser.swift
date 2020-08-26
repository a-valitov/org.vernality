//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/26/20
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

public protocol PCUser {
    var id: String? { get }
    var roles: [PCRole] { get }
    var email: String? { get }
    var username: String? { get }
    var member: PCMember? { get }
    var organization: PCOrganization? { get }
    var supplier: PCSupplier? { get }
    var administrator: PCAdministrator? { get }
}

public extension PCUser {
    var any: AnyPCUser {
        return AnyPCUser(object: self)
    }
}

public struct PCUserStruct: PCUser {
    public var id: String?
    public var roles: [PCRole]
    public var email: String?
    public var username: String?
    public var member: PCMember?
    public var organization: PCOrganization?
    public var supplier: PCSupplier?
    public var administrator: PCAdministrator?

    public init(roles: [PCRole]) {
        self.roles = roles
    }
}

public struct AnyPCUser: PCUser, Equatable, Hashable {
    public var id: String? {
        return self.object.id
    }

    public var roles: [PCRole] {
        return self.object.roles
    }

    public var email: String? {
        return self.object.email
    }

    public var username: String? {
        return self.object.username
    }

    public var member: PCMember? {
        return self.object.member
    }

    public var organization: PCOrganization? {
        return self.object.organization
    }

    public var supplier: PCSupplier? {
        return self.object.supplier
    }

    public var administrator: PCAdministrator? {
        return self.object.administrator
    }

    public init(object: PCUser) {
        self.object = object
    }

    public static func == (lhs: AnyPCUser, rhs: AnyPCUser) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }

    private let object: PCUser
}
