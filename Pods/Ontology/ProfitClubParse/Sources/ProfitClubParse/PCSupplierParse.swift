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
import ProfitClubModel

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
//        if let owner = self["owner"] as? PFObject {
//            result.owner = owner.pcUser?.any
//        }
        return result
    }
}

public extension PCSupplier {
    var parse: PCSupplierParse {
        let result = PCSupplierParse()
        result.objectId = self.id
        result.name = self.name
        result.inn = self.inn
        result.contact = self.contact
        result.phone = self.phone
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

    public var owner: PCUser?
    
    @NSManaged public var name: String?
    @NSManaged public var inn: String?
    @NSManaged public var contact: String?
    @NSManaged public var phone: String?
    @NSManaged public var statusString: String?

    public static func parseClassName() -> String {
        return "Supplier"
    }
}
