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
    var pcMember: PCMember {
        var result = PCMemberStruct()
        result.id = self.objectId
        result.firstName = self["firstName"] as? String
        result.lastName = self["lastName"] as? String
        if let statusString = self["statusString"] as? String {
            result.status = PCMemberStatus(rawValue: statusString)
        }
        if let owner = self["owner"] as? PFObject, owner.isDataAvailable {
            result.owner = owner.pcUser?.any
        }
        if let organization = self["organization"] as? PFObject, organization.isDataAvailable {
            result.organization = organization.pcOrganization.any
        }
        return result
    }
}

public extension PCMember {
    var parse: PCMemberParse {
        let result = PCMemberParse()
        result.objectId = self.id
        result.firstName = self.firstName
        result.lastName = self.lastName
        result.owner = self.owner
        result.organization = self.organization
        result.status = self.status
        return result
    }
}

public final class PCMemberParse: PFObject, PFSubclassing, PCMember {
    public var id: String? {
        return self.objectId
    }
    public var status: PCMemberStatus? {
        get {
            if let statusString = self.statusString {
                return PCMemberStatus(rawValue: statusString)
            } else {
                return nil
            }
        }
        set {
            self.statusString = newValue?.rawValue
        }
    }

    public var owner: PCUser?
    public var organization: PCOrganization?

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var statusString: String?

    public static func parseClassName() -> String {
        return "Member"
    }
}
