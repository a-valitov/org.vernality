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
        return result
    }
}

public extension PCMember {
    var parse: PCMemberParse {
        let result = PCMemberParse()
        result.objectId = self.id
        result.firstName = self.firstName
        result.lastName = self.lastName
        return result
    }
}

public final class PCMemberParse: PFObject, PFSubclassing, PCMember {
    public var id: String? {
        return self.objectId
    }
    @NSManaged public var username: String
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

    public static func parseClassName() -> String {
        return "Member"
    }
}
