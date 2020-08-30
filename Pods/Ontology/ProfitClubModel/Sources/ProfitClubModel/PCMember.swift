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

public protocol PCMember {
    var id: String? { get }
    var firstName: String? { get }
    var lastName: String? { get }
}

public extension PCMember {
    var any: AnyPCMember {
        return AnyPCMember(object: self)
    }
}

public struct PCMemberStruct: PCMember {
    public var id: String?
    public var firstName: String?
    public var lastName: String?

    public init() {}
}

public struct AnyPCMember: PCMember, Equatable, Hashable {
    public var id: String? {
        return self.object.id
    }
    
    public var firstName: String? {
        return self.object.firstName
    }

    public var lastName: String? {
        return self.object.lastName
    }

    public init(object: PCMember) {
        self.object = object
    }

    public static func == (lhs: AnyPCMember, rhs: AnyPCMember) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }

    private let object: PCMember
}

