//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 22.10.2020
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

public protocol PCAction {
    var id: String? { get }
    var message: String? { get }
    var descriptionOf: String? { get }
    var link: String? { get }
    var status: PCActionStatus? { get }
}

public enum PCActionStatus: String {
    case onReview
    case approved
    case rejected
    case excluded
}

public extension PCAction {
    var any: AnyPCAction {
        return AnyPCAction(object: self)
    }
}

public struct PCActionStruct: PCAction {
    public var id: String?
    public var message: String?
    public var descriptionOf: String?
    public var link: String?
    public var status: PCActionStatus?

    public init() {}
}

public struct AnyPCAction: PCAction, Equatable, Hashable {
    public var id: String? {
        return self.object.id
    }

    public var message: String? {
        return self.object.message
    }

    public var descriptionOf: String? {
        return self.object.descriptionOf
    }

    public var link: String? {
        return self.object.link
    }

    public var status: PCActionStatus? {
        return self.object.status
    }

    public init(object: PCAction) {
        self.object = object
    }

    public static func == (lhs: AnyPCAction, rhs: AnyPCAction) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }

    private let object: PCAction
}
