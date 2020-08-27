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

public extension PCUser {
    var parse: PCUserParse {
        let result = PCUserParse()
        result.username = self.username
        result.email = self.email
        result.member = self.member
        result.organization = self.organization
        result.supplier = self.supplier
        return result
    }
}

public final class PCUserParse: PFUser, PCUser {
    public var id: String? {
        return self.objectId
    }

    public var member: PCMember?
    public var organization: PCOrganization?
    public var supplier: PCSupplier?
}
