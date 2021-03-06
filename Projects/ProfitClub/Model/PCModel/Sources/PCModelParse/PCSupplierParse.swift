//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/27/20
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
    var pcSupplier: PCSupplier {
        var result = PCSupplierStruct()
        result.id = self.objectId
        result.name = self["name"] as? String
        result.phone = self["phone"] as? String
        result.contact = self["contact"] as? String
        result.inn = self["inn"] as? String
        if let statusString = self["statusString"] as? String {
            result.status = PCSupplierStatus(rawValue: statusString)
        }

        if let supplierParse = self as? PCSupplierParse, let owner = supplierParse.owner {
            result.owner = owner
        } else if let owner = self["owner"] as? PFObject, owner.isDataAvailable {
            result.owner = owner.pcUser?.any
        }

        if let fileObject = self["imageFile"] as? PFFileObject,
            let urlString = fileObject.url,
            let imageUrl = URL(string: urlString) {
            result.imageUrl = imageUrl
        } else if let supplierParse = self as? PCSupplierParse {
            result.imageUrl = supplierParse.imageUrl
            result.image = supplierParse.image
        }
        
        return result
    }
}

public extension PCSupplier {
    var parse: PCSupplierParse {
        let result = PCSupplierParse(withoutDataWithObjectId: self.id)
        result.name = self.name
        result.inn = self.inn
        result.contact = self.contact
        result.phone = self.phone
        result.image = self.image
        result.owner = self.owner
        result.status = self.status
        return result
    }
}

public final class PCSupplierParse: PFObject, PFSubclassing, PCSupplier {
    public var id: String? {
        return self.objectId
    }
    public var status: PCSupplierStatus? {
        get {
            if let statusString = self.statusString {
                return PCSupplierStatus(rawValue: statusString)
            } else {
                return nil
            }
        }
        set {
            self.statusString = newValue?.rawValue
        }
    }
    
    @NSManaged public var name: String?
    @NSManaged public var inn: String?
    @NSManaged public var contact: String?
    @NSManaged public var phone: String?
    @NSManaged public var statusString: String?
    @NSManaged public var imageFile: PFFileObject?
    public var image: UIImage?
    public var imageUrl: URL?
    public var owner: PCUser?

    public static func parseClassName() -> String {
        return "Supplier"
    }
}
