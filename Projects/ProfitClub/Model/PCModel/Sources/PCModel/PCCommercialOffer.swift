//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 10/31/20
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

public protocol PCCommercialOffer {
    var id: String? { get }
    var supplier: PCSupplier? { get }
    var attachments: [Data] { get }
    var attachmentUrls: [URL] { get }
    var attachmentNames: [String] { get }
    var createdAt: Date? { get }
    var message: String? { get }
    var image: UIImage? { get }
    var imageUrl: URL? { get }
    var status: PCCommercialOfferStatus? { get }
}

public enum PCCommercialOfferStatus: String {
    case onReview
    case approved
    case rejected
}

public extension PCCommercialOffer {
    var any: AnyPCCommercialOffer {
        return AnyPCCommercialOffer(object: self)
    }
}

public struct PCCommercialOfferStruct: PCCommercialOffer {
    public var id: String?
    public var supplier: PCSupplier?
    public var attachments = [Data]()
    public var attachmentUrls = [URL]()
    public var attachmentNames = [String]()
    public var createdAt: Date?
    public var message: String?
    public var link: String?
    public var image: UIImage?
    public var imageUrl: URL?
    public var status: PCCommercialOfferStatus?

    public init() {}
}

public struct AnyPCCommercialOffer: PCCommercialOffer, Equatable, Hashable {
    public var id: String? {
        return self.object.id
    }

    public var supplier: PCSupplier? {
        return self.object.supplier
    }

    public var attachments: [Data] {
        return self.object.attachments
    }

    public var attachmentUrls: [URL] {
        return self.object.attachmentUrls
    }

    public var attachmentNames: [String] {
        return self.object.attachmentNames
    }

    public var createdAt: Date? {
        return self.object.createdAt
    }

    public var message: String? {
        return self.object.message
    }

    public var image: UIImage? {
        return self.object.image
    }

    public var imageUrl: URL? {
        return self.object.imageUrl
    }

    public var status: PCCommercialOfferStatus? {
        return self.object.status
    }

    public init(object: PCCommercialOffer) {
        self.object = object
    }

    public static func == (lhs: AnyPCCommercialOffer, rhs: AnyPCCommercialOffer) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }

    private let object: PCCommercialOffer
}
