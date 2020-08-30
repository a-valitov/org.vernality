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
        result.objectId = self.id
        result.username = self.username
        result.email = self.email
        result.member = self.member
        result.organizations = self.organizations
        result.suppliers = self.suppliers
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
    public var organizations: [PCOrganization]?
    public var suppliers: [PCSupplier]?
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

    lazy var member: PCMember? = {
        return try? self.pfUser.relation(forKey: "member").query().getFirstObject().pcMember
    }()

    lazy var organizations: [PCOrganization]? = {
        return try? self.pfUser.relation(forKey: "organizations").query().findObjects().map({ $0.pcOrganization })
    }()

    lazy var suppliers: [PCSupplier]? = {
        return try? self.pfUser.relation(forKey: "suppliers").query().findObjects().map({ $0.pcSupplier })
    }()

    init(pfUser: PFUser) {
        self.pfUser = pfUser
    }
    private let pfUser: PFUser
}

fileprivate let isAdministratorKey = "isAdministrator"
