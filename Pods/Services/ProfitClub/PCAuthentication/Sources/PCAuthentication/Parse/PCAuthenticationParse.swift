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

    private var parseUser: PCUserParse?

    func login(username: String, password: String, result: @escaping ((Result<AnyPCUser, Error>) -> Void)) {
        PFUser.logInWithUsername(inBackground: username, password: password) { [weak self] (user, error) in
            if let error = error {
                result(.failure(error))
            } else if let user = user?.pcUser?.any {
                self?.user = user
                result(.success(user))
            } else {
                result(.failure(PCAuthenticationError.bothResultAndErrorAreNil))
            }
        }
    }

    func add(supplier: PCSupplier, result: @escaping ((Result<PCSupplier, Error>) -> Void)) {
        let parseSupplier = supplier.parse
        let currentUser = PFUser.current()
        parseSupplier.saveInBackground { (succeeded, error) in
            if let error = error {
                result(.failure(error))
            } else {
                currentUser?.relation(forKey: "suppliers").add(parseSupplier)
                currentUser?.saveInBackground(block: { (succeeded, error) in
                    if let error = error {
                        result(.failure(error))
                    } else {
                        result(.success(supplier))
                    }
                })
            }

        }
    }

    func add(member: PCMember, result: @escaping ((Result<PCMember, Error>) -> Void)) {
        let parseMember = member.parse
        let currentUser = PFUser.current()
        parseMember.saveInBackground { (succeeded, error)  in
            if let error = error {
                result(.failure(error))
            } else {
                currentUser?.relation(forKey: "member").add(parseMember)
                currentUser?.saveInBackground(block: { (succeeded, error) in
                    if let error = error {
                        result(.failure(error))
                    } else {
                        result(.success(member))
                    }
                })
            }
        }
    }

    func add(organization: PCOrganization, result: @escaping ((Result<PCOrganization, Error>) -> Void)) {
        let parseOrganization = organization.parse
        let currentUser = PFUser.current()
        parseOrganization.saveInBackground { (succeeded, error) in
            if let error = error {
                result(.failure(error))
            } else {
                currentUser?.relation(forKey: "organizations").add(parseOrganization)
                currentUser?.saveInBackground(block: { (succeeded, error) in
                    if let error = error {
                        result(.failure(error))
                    } else {
                        result(.success(organization))
                    }
                })
            }
        }
    }

    func register(user: PCUser, password: String, result: @escaping ((Result<AnyPCUser, Error>) -> Void)) {
        let group = DispatchGroup()
        var finalError: Error?
        let parseUser = user.parse
        parseUser.password = password
        group.enter()
        parseUser.signUpInBackground { [weak self] (success, error) in
            if let error = error {
                finalError = error
            } else {
                let defaultACL = PFACL(user: parseUser)
                defaultACL.setReadAccess(true, forRoleWithName: PCRole.administrator.rawValue)
                PFACL.setDefault(defaultACL, withAccessForCurrentUser: true)

                // member
                if let members = user.members {
                    members.forEach { (member) in
                        group.enter()
                        self?.add(member: member, result: { (result) in
                            switch result {
                            case .success:
                                break
                            case .failure(let error):
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
                        self?.add(organization: organization, result: { (result) in
                            switch result {
                            case .success:
                                break
                            case .failure(let error):
                                finalError = error
                            }
                            group.leave()
                        })
                    }
                }

                // supplier
                if let suppliers = user.suppliers {
                    suppliers.forEach { (supplier) in
                        group.enter()
                        self?.add(supplier: supplier, result: { (result) in
                            switch result {
                            case .success:
                                break
                            case .failure(let error):
                                finalError = error
                            }
                            group.leave()
                        })
                    }
                }
            }
            group.leave()
        }

        group.notify(queue: .main) {
            if let error = finalError {
                result(.failure(error))
            } else if let user = self.user {
                result(.success(user))
            } else {
                result(.failure(PCAuthenticationError.userIsStillNilAfterRegistration))
            }
        }
    }
}
