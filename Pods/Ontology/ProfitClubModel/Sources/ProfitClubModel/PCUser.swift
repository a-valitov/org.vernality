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
    var email: String? { get }
    var username: String? { get }

    var members: [PCMember]? { get }
    var organizations: [PCOrganization]? { get }
    var suppliers: [PCSupplier]? { get }
}

public extension PCUser {
    var any: AnyPCUser {
        return AnyPCUser(object: self)
    }
}

public struct PCUserStruct: PCUser {
    public var id: String?
    public var email: String?
    public var username: String?
    public var members: [PCMember]?
    public var organizations: [PCOrganization]?
    public var suppliers: [PCSupplier]?

    public init() {}
}

public struct AnyPCUser: PCUser, Equatable, Hashable {
    public var id: String? {
        return self.object.id
    }

    public var email: String? {
        return self.object.email
    }

    public var username: String? {
        return self.object.username
    }

    public var members: [PCMember]? {
        return self.object.members
    }

    public var organizations: [PCOrganization]? {
        return self.object.organizations
    }

    public var suppliers: [PCSupplier]? {
        return self.object.suppliers
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
