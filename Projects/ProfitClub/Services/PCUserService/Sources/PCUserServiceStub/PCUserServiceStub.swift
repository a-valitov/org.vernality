//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/30/20
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
import UIKit
import PCUserService
import PCAuthentication
import PCModel

public final class PCUserServiceStub: PCUserService {
    public var user: AnyPCUser? {
        return self.authentication.user
    }

    public init(authentication: PCAuthentication) {
        self.authentication = authentication
    }

    public func isOnReview() -> Bool {
        let isOnMemberReview = (self.user?.members?.contains(where: { $0.status == .onReview })) ?? false
        let isOnOrganizationReview = (self.user?.organizations?.contains(where: { $0.status == .onReview })) ?? false
        let isOnSupplierReview = (self.user?.suppliers?.contains(where: { $0.status == .onReview })) ?? false
        return isOnMemberReview || isOnOrganizationReview || isOnSupplierReview

    }

    public func logout(result: @escaping (Result<Bool, Error>) -> Void) {
        result(.success(true))
    }

    public func reload(result: @escaping (Result<AnyPCUser, Error>) -> Void) {
        if let user = self.user {
            result(.success(user))
        } else {
            result(.failure(PCUserServiceError.userIsNil))
        }
    }

    public func editProfile(member: PCMember, image: UIImage, result: @escaping (Result<PCMember, Error>) -> Void) {
        result(.success(member))
    }

    private var authentication: PCAuthentication
}
