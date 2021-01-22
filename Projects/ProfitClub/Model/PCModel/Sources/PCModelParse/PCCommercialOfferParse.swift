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
import Parse

public extension PFObject {
    var pcCommercialOffer: PCCommercialOffer {
        var result = PCCommercialOfferStruct()
        result.id = self.objectId
        result.message = self["message"] as? String
        result.attachmentNames = self["attachmentNames"] as? [String] ?? []
        if let fileObject = self["imageFile"] as? PFFileObject,
            let urlString = fileObject.url,
            let imageUrl = URL(string: urlString) {
            result.imageUrl = imageUrl
        }
        if let fileObjects = self["attachmentFiles"] as? [PFFileObject] {
            result.attachmentUrls = fileObjects.compactMap({ fileObject -> URL? in
                if let urlString = fileObject.url,
                   let attachmentUrl = URL(string: urlString) {
                    return attachmentUrl
                } else {
                    return nil
                }
            })
        }
        if let statusString = self["statusString"] as? String {
            result.status = PCCommercialOfferStatus(rawValue: statusString)
        }
        if let supplier = self["supplier"] as? PFObject {
            result.supplier = supplier.pcSupplier.any
        }
        return result
    }
}

public extension PCCommercialOffer {
    var parse: PCCommercialOfferParse {
        let result = PCCommercialOfferParse()
        result.objectId = self.id
        result.message = self.message
        result.image = self.image
        result.attachments = self.attachments
        result.attachmentNames = self.attachmentNames
        result.status = self.status
        return result
    }

}

public final class PCCommercialOfferParse: PFObject, PFSubclassing, PCCommercialOffer {
    public var id: String? {
        return self.objectId
    }
    public var status: PCCommercialOfferStatus? {
        get {
            if let statusString = self.statusString {
                return PCCommercialOfferStatus(rawValue: statusString)
            } else {
                return nil
            }
        }
        set {
            self.statusString = newValue?.rawValue
        }
    }

    public var supplier: PCSupplier?
    public var organization: PCOrganization?
    @NSManaged public var message: String?
    @NSManaged public var attachmentNames: [String]
    @NSManaged public var imageFile: PFFileObject?
    @NSManaged public var attachmentFiles: [PFFileObject]
    @NSManaged public var statusString: String?
    public var image: UIImage?
    public var imageUrl: URL?
    public var attachments = [Data]()
    public var attachmentUrls = [URL]()

    public static func parseClassName() -> String {
        return "CommercialOffer"
    }
}
