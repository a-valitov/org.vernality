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
import PCModel
import PCAuthentication

final class PCAuthenticationParse: PCAuthentication {
    var user: AnyPCUser? = PCUserStruct().any

    func login(username: String, password: String, result: @escaping ((Result<AnyPCUser, Error>) -> Void)) {
        if let anyUser = self.user?.any {
            result(.success(anyUser))
        } else {
            result(.failure(PCAuthenticationError.failedToLogin))
        }
    }

    func resetPassword(email: String, result: @escaping ((Result<Bool, Error>) -> Void)) {
        result(.success(true))
    }

    func add(supplier: PCSupplier, result: @escaping ((Result<PCSupplier, Error>) -> Void)) {
        result(.success(supplier))
    }

    func add(member: PCMember, in organization: PCOrganization, result: @escaping ((Result<PCMember, Error>) -> Void)) {
        result(.success(member))
    }

    func add(organization: PCOrganization, result: @escaping ((Result<PCOrganization, Error>) -> Void)) {
        result(.success(organization))
    }

    func register(user: PCUser, password: String, result: @escaping ((Result<AnyPCUser, Error>) -> Void)) {
        result(.success(user.any))
    }
}
