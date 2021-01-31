//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/26/20
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
import PCModel

final class PCUserPersistenceParse: PCUserPersistence {
    var user: AnyPCUser? {
        get {
            if let parseUser = self.parseUser {
                return parseUser.any
            } else {
                self.parseUser = PFUser.current()?.pcUser
                return self.parseUser?.any
            }
        }
        set {
            if let parseUser = newValue?.parse {
                self.parseUser = parseUser
            } else {
                self.parseUser = nil
            }
        }
    }

    var lastUsedRole: PersistentRole? {
        get {
            if let value = self.prefs.string(forKey: self.lastUsedRoleKey) {
                if value == "administrator" {
                    return .administrator
                } else if value.starts(with: "m") {
                    let id = String(value.dropFirst())
                    let query = PCMemberParse.query()?.fromPin()
                    if let member = try? query?.getObjectWithId(id) as? PCMemberParse {
                        return .member(member)
                    } else {
                        return nil
                    }

                } else if value.starts(with: "o") {
                    let id = String(value.dropFirst())
                    let query = PCOrganizationParse.query()?.fromPin()
                    if let organization = try? query?.getObjectWithId(id) as? PCOrganizationParse {
                        return .organization(organization)
                    } else {
                        return nil
                    }
                } else if value.starts(with: "s") {
                    let id = String(value.dropFirst())
                    let query = PCSupplierParse.query()?.fromPin()
                    if let supplier = try? query?.getObjectWithId(id) as? PCSupplierParse {
                        return .supplier(supplier)
                    } else {
                        return nil
                    }
                } else {
                    return nil
                }
            } else {
                return nil
            }
        }
        set {
            switch newValue {
            case .administrator:
                self.prefs.setValue("administrator", forKey: self.lastUsedRoleKey)
            case .member(let member):
                self.prefs.setValue("m" + (member.id ?? ""), forKey: self.lastUsedRoleKey)
                member.parse.pinInBackground()
            case .organization(let organization):
                self.prefs.setValue("o" + (organization.id ?? ""), forKey: self.lastUsedRoleKey)
                organization.parse.pinInBackground()
            case .supplier(let supplier):
                self.prefs.setValue("s" + (supplier.id ?? ""), forKey: self.lastUsedRoleKey)
                supplier.parse.pinInBackground()
            case .none:
                self.prefs.setValue(nil, forKey: self.lastUsedRoleKey)
            }
        }
    }

    private var parseUser: PCUserParse?
    private let prefs = UserDefaults.standard
    private let lastUsedRoleKey = "PCUserPersistenceParse.lastUsedRoleKey"
}
