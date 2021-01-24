//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/30/20
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General License for more details.
//
//  You should have received a copy of the GNU General License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

import Foundation
import UIKit
import PCUserService
import PCModel

final class PCUserServiceStub: PCUserService {
    var user: PCUser

    init(user: PCUser) {
        self.user = user
    }

    func isOnReview() -> Bool {
        let isOnMemberReview = (self.user.members?.contains(where: { $0.status == .onReview })) ?? false
        let isOnOrganizationReview = (self.user.organizations?.contains(where: { $0.status == .onReview })) ?? false
        let isOnSupplierReview = (self.user.suppliers?.contains(where: { $0.status == .onReview })) ?? false
        return isOnMemberReview || isOnOrganizationReview || isOnSupplierReview

    }

    func logout(result: @escaping (Result<Bool, Error>) -> Void) {
        result(.success(true))
    }

    func reload(result: @escaping (Result<AnyPCUser, Error>) -> Void) {
        result(.success(self.user.any))
    }

    func editProfile(member: PCMember, image: UIImage, result: @escaping (Result<PCMember, Error>) -> Void) {
        result(.success(member))
    }

    func add(member: PCMember, in organization: PCOrganization, result: @escaping ((Result<PCMember, Error>) -> Void)) {
//        self.user?.members?.append(member)
        result(.success(member))
    }

    func add(supplier: PCSupplier, result: @escaping ((Result<PCSupplier, Error>) -> Void)) {
//        self.user?.suppliers?.append(supplier)
        result(.success(supplier))
    }

    func add(organization: PCOrganization, result: @escaping ((Result<PCOrganization, Error>) -> Void)) {
//        self.user?.organizations?.append(organization)
        result(.success(organization))
    }
}
