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
import UIKit

public protocol PCOrganization {
    var id: String? { get }
    var name: String? { get }
    var inn: String? { get }
    var contact: String? { get }
    var phone: String? { get }
    var owner: PCUser? { get }
    var image: UIImage? { get }
    var imageUrl: URL? { get }
    var status: PCOrganizationStatus? { get }
}

public enum PCOrganizationStatus: String {
    case onReview
    case approved
    case rejected
    case excluded
}

public extension PCOrganization {
    var any: AnyPCOrganization {
        return AnyPCOrganization(object: self)
    }
}

public struct PCOrganizationStruct: PCOrganization {
    public var id: String?
    public var name: String?
    public var inn: String?
    public var contact: String?
    public var phone: String?
    public var owner: PCUser?
    public var image: UIImage?
    public var imageUrl: URL?
    public var status: PCOrganizationStatus?

    public init() {}
}

public struct AnyPCOrganization: PCOrganization, Equatable, Hashable {
    public var id: String? {
        return self.object.id
    }

    public var name: String? {
        return self.object.name
    }

    public var inn: String? {
        return self.object.inn
    }

    public var contact: String? {
        return self.object.contact
    }

    public var phone: String? {
        return self.object.phone
    }

    public var owner: PCUser? {
        return self.object.owner
    }

    public var image: UIImage? {
        return self.object.image
    }

    public var imageUrl: URL? {
        return self.object.imageUrl
    }

    public var status: PCOrganizationStatus? {
        return self.object.status
    }

    public init(object: PCOrganization) {
        self.object = object
    }

    public static func == (lhs: AnyPCOrganization, rhs: AnyPCOrganization) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }

    private let object: PCOrganization
}
