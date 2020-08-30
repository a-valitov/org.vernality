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
import PCAuthentication
import ProfitClubModel
import Parse
import ProfitClubParse

public final class PCUserServiceParse: PCUserService {
    public var user: AnyPCUser? {
        return self.authentication.user
    }
    
    public init(authentication: PCAuthentication) {
        self.authentication = authentication
    }

    public func reload(result: @escaping (Result<AnyPCUser, Error>) -> Void) {
        guard let parseUser = self.user?.parse else {
            result(.failure(PCUserServiceError.userIsNil))
            return
        }
        var finalError: Error?
        var finalUser: PCUserParse?
        let group = DispatchGroup()
        group.enter()
        parseUser.fetchInBackground { (pfObject, error) in
            if let error = error {
                finalError = error
            } else {
                if let pfUser = pfObject?.pcUser {
                    group.enter()
                    parseUser.relation(forKey: "member").query().getFirstObjectInBackground(block: { (pfMember, error) in
                        if let error = error {
                            finalError = error
                        } else {
                            pfUser.member = pfMember?.pcMember
                        }
                        group.leave()
                    })
                    group.enter()
                    parseUser.relation(forKey: "organizations").query().findObjectsInBackground { (pfOrganizations, error) in
                        if let error = error {
                            finalError = error
                        } else {
                            pfUser.organizations = pfOrganizations?.map({ $0.pcOrganization })
                        }
                        group.leave()
                    }
                    group.enter()
                    parseUser.relation(forKey: "suppliers").query().findObjectsInBackground { (pfSuppliers, error) in
                        if let error = error {
                            finalError = error
                        } else {
                            pfUser.suppliers = pfSuppliers?.map({ $0.pcSupplier })
                        }
                        group.leave()
                    }
                    finalUser = pfUser
                } else {
                    finalError = PCUserServiceError.userIsNotPFUser
                }
            }
            group.leave()
        }

        group.notify(queue: .main) { [weak self] in
            if let error = finalError {
                result(.failure(error))
            } else if let user = finalUser {
                self?.authentication.user = user.any
                result(.success(user.any))
            } else {
                result(.failure(PCUserServiceError.userIsNil))
            }
        }
    }

    private var authentication: PCAuthentication
}
