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
    var pcOrganization: PCOrganization {
        var result = PCOrganizationStruct()
        result.id = self.objectId
        result.name = self["name"] as? String
        result.inn = self["inn"] as? String
        result.contact = self["contact"] as? String
        result.phone = self["phone"] as? String
        if let statusString = self["statusString"] as? String {
            result.status = PCOrganizationStatus(rawValue: statusString)
        }

        if let organizationParse = self as? PCOrganizationParse, let owner = organizationParse.owner {
            result.owner = owner
        } else if let owner = self["owner"] as? PFObject, owner.isDataAvailable {
            result.owner = owner.pcUser?.any
        }

        if let fileObject = self["imageFile"] as? PFFileObject,
            let urlString = fileObject.url,
            let imageUrl = URL(string: urlString) {
            result.imageUrl = imageUrl
        } else if let organizationParse = self as? PCOrganizationParse {
            result.imageUrl = organizationParse.imageUrl
            result.image = organizationParse.image
        }
        return result
    }
}

public extension PCOrganization {
    var parse: PCOrganizationParse {
        let result = PCOrganizationParse(withoutDataWithObjectId: self.id)
        result.name = self.name
        result.inn = self.inn
        result.contact = self.contact
        result.phone = self.phone
        result.owner = self.owner
        result.image = self.image
        result.statusString = self.status?.rawValue
        return result
    }
}

public final class PCOrganizationParse: PFObject, PFSubclassing, PCOrganization {
    public var id: String? {
        return self.objectId
    }
    public var status: PCOrganizationStatus? {
        get {
            if let statusString = self.statusString {
                return PCOrganizationStatus(rawValue: statusString)
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
        return "Organization"
    }
}
