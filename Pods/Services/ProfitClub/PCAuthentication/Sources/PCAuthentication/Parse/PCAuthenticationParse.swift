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
import ProfitClubModel
import ProfitClubParse

final class PCAuthenticationParse: PCAuthentication {
    var user: AnyPCUser? {
        return PFUser.current()?.pc.any
    }

    func login(username: String, password: String, result: @escaping ((Result<AnyPCUser, Error>) -> Void)) {
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if let error = error {
                result(.failure(error))
            } else if let user = user {
                result(.success(user.pc.any))
            }
        }
    }

    func register(user: PCUser, password: String, result: @escaping ((Result<AnyPCUser, Error>) -> Void)) {
        let group = DispatchGroup()
        var finalError: Error?
        let parseUser = user.parse
        parseUser.password = password
        group.enter()
        parseUser.signUpInBackground { (success, error) in
            if let error = error {
                finalError = error
            } else {
                let defaultACL = PFACL(user: parseUser)
                defaultACL.setReadAccess(true, forRoleWithName: PCRole.administrator.rawValue)
                PFACL.setDefault(defaultACL, withAccessForCurrentUser: true)

                let currentUser = PFUser.current()

                // member
                if let parseMember = user.member?.parse {
                    group.enter()
                    parseMember.saveInBackground { (succeeded, error)  in
                        if let error = error {
                            finalError = error
                        }
                        currentUser?.relation(forKey: "member").add(parseMember)
                        currentUser?.saveInBackground(block: { (result, error) in
                            if let error = error {
                                finalError = error
                            }
                            group.leave()
                        })
                    }
                }

                // organization
                if let organizations = user.organizations {
                    organizations.forEach { (organization) in
                        group.enter()
                        let parseOrganization = organization.parse
                        parseOrganization.saveInBackground { (succeeded, error) in
                            if let error = error {
                                finalError = error
                            }
                            currentUser?.relation(forKey: "organizations").add(parseOrganization)
                            currentUser?.saveInBackground(block: { (result, error) in
                                if let error = error {
                                    finalError = error
                                }
                                group.leave()
                            })
                        }
                    }
                }

                // supplier
                if let suppliers = user.suppliers {
                    suppliers.forEach { (supplier) in
                        group.enter()
                        let parseSupplier = supplier.parse
                        parseSupplier.saveInBackground { (succeeded, error)  in
                            if let error = error {
                                finalError = error
                            }
                            currentUser?.relation(forKey: "suppliers").add(parseSupplier)
                            currentUser?.saveInBackground(block: { (result, error) in
                                if let error = error {
                                    finalError = error
                                }
                                group.leave()
                            })
                        }
                    }
                }
            }
            group.leave()
        }

        group.notify(queue: .main) {
            if let error = finalError {
                result(.failure(error))
            } else {
                result(.success(user.any))
            }
        }
    }
}
