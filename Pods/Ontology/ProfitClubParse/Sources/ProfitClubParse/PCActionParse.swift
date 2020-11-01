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
import Parse
import ProfitClubModel

public extension PFObject {
    var pcAction: PCAction {
        var result = PCActionStruct()
        result.id = self.objectId
        result.message = self["message"] as? String
        result.descriptionOf = self["descriptionOf"] as? String
        result.link = self["link"] as? String
        result.startDate = self["startDate"] as? String
        result.endDate = self["endDate"] as? String
        if let fileObject = self["imageFile"] as? PFFileObject,
            let urlString = fileObject.url,
            let imageUrl = URL(string: urlString) {
            result.imageUrl = imageUrl
        }
        if let statusString = self["statusString"] as? String {
            result.status = PCActionStatus(rawValue: statusString)
        }
        if let supplier = self["supplier"] as? PFObject {
            result.supplier = supplier.pcSupplier.any
        }
        return result
    }
}

public extension PCAction {
    var parse: PCActionParse {
        let result = PCActionParse()
        result.objectId = self.id
        result.message = self.message
        result.descriptionOf = self.descriptionOf
        result.link = self.link
        result.image = self.image
        result.startDate = self.startDate
        result.endDate = self.endDate
        result.status = self.status
        return result
    }
    
}

public final class PCActionParse: PFObject, PFSubclassing, PCAction {
    public var id: String? {
        return self.objectId
    }
    public var status: PCActionStatus? {
        get {
            if let statusString = self.statusString {
                return PCActionStatus(rawValue: statusString)
            } else {
                return nil
            }
        }
        set {
            self.statusString = newValue?.rawValue
        }
    }

    public var supplier: PCSupplier?

    @NSManaged public var message: String?
    @NSManaged public var descriptionOf: String?
    @NSManaged public var link: String?
    @NSManaged public var statusString: String?
    @NSManaged public var startDate: String?
    @NSManaged public var endDate: String?
    @NSManaged public var imageFile: PFFileObject?
    public var image: UIImage?
    public var imageUrl: URL?

    public static func parseClassName() -> String {
        return "Action"
    }
}
