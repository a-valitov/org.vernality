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

public extension PFUser {
    var pc: PCUser {
        return PCPFUserWrapper(pfUser: self)
    }
}

public final class PCUserParse: PFUser, PCUser {
    public var id: String? {
        return self.objectId
    }

    public var isAdministrator: Bool {
        return self[isAdministratorKey] as? Bool ?? false
    }

    public var member: PCMember?
    public var organization: PCOrganization?
    public var supplier: PCSupplier?
}

private final class PCPFUserWrapper: PCUser {
    var id: String? {
        return self.pfUser.objectId
    }

    var email: String? {
        return self.pfUser.email
    }

    var username: String? {
        return self.pfUser.username
    }

    var isAdministrator: Bool {
        return self.pfUser[isAdministratorKey] as? Bool ?? false
    }

    var member: PCMember? {
        return self.pfUser["member"] as? PCMemberParse
    }

    var organization: PCOrganization? {
        return self.pfUser["organization"] as? PCOrganizationParse
    }

    var supplier: PCSupplier? {
        return self.pfUser["supplier"] as? PCSupplierParse
    }

    init(pfUser: PFUser) {
        self.pfUser = pfUser
    }
    private let pfUser: PFUser
}

fileprivate let isAdministratorKey = "isAdministrator"
