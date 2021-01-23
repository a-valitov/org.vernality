//
//  PCSUUser.swift
//  Demo
//
//  Created by Rinat Enikeev on 23.01.2021.
//

import Foundation
import PCModel

class PCUserSU: ObservableObject, PCUser {
    @Published
    var id: String?

    @Published
    var username: String?

    @Published
    var roles: [PCRole]?

    @Published
    var members: [PCMember]?

    @Published
    var organizations: [PCOrganization]?

    @Published
    var suppliers: [PCSupplier]?

    @Published
    var email: String?

    init(id: String?,
         email: String?,
         username: String?,
         roles: [PCRole]?,
         members: [PCMember]?,
         organizations: [PCOrganization]?,
         suppliers: [PCSupplier]?
         ) {
        self.id = id
        self.email = email
        self.username = username
        self.roles = roles
        self.members = members
        self.organizations = organizations
        self.suppliers = suppliers
    }
}

extension PCUser {
    var su: PCUserSU {
        return PCUserSU(
            id: self.id,
            email: self.email,
            username: self.username,
            roles: self.roles,
            members: self.members,
            organizations: self.organizations,
            suppliers: self.suppliers
        )
    }
}
