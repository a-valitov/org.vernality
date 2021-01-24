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
import PCModel
import Parse

final class PCUserServiceParse: PCUserService {
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
        PFUser.logOutInBackground { error in
            if let error = error {
                result(.failure(error))
            } else {
//                self?.userPersistence.user = nil
                result(.success(true))
            }
        }
    }

    func reload(result: @escaping (Result<AnyPCUser, Error>) -> Void) {
        let parseUser = self.user.parse
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
                    let query = PFRole.query()
                    query?.whereKey("users", equalTo: parseUser)
                    query?.findObjectsInBackground(block: { (roles, error) in
                        if let error = error {
                            finalError = error
                        } else if let roles = roles {
                            let pfRoles = roles.compactMap({ ($0 as? PFRole) })
                            pfUser.roles = pfRoles.compactMap({ PCRole(rawValue: $0.name) })
                        } else {
                            finalError = PCUserServiceError.bothResultAndErrorAreNil
                        }
                        group.leave()
                    })

                    group.enter()
                    parseUser.relation(forKey: "members").query().includeKeys(["organization", "owner"]).findObjectsInBackground(block: { (pfMembers, error) in
                        if let error = error {
                            finalError = error
                        } else {
                            pfUser.members = pfMembers?.map({ $0.pcMember })
                        }
                        group.leave()
                    })
                    group.enter()
                    parseUser.relation(forKey: "organizations").query().includeKey("owner").findObjectsInBackground { (pfOrganizations, error) in
                        if let error = error {
                            finalError = error
                        } else {
                            pfUser.organizations = pfOrganizations?.map({ $0.pcOrganization })
                        }
                        group.leave()
                    }
                    group.enter()
                    parseUser.relation(forKey: "suppliers").query().includeKey("owner").findObjectsInBackground { (pfSuppliers, error) in
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

        group.notify(queue: .main) {
            if let error = finalError {
                result(.failure(error))
            } else if let user = finalUser {
//                self?.userPersistence.user = user.any
                result(.success(user.any))
            } else {
                result(.failure(PCUserServiceError.userIsNil))
            }
        }
    }

    func editProfile(member: PCMember, image: UIImage, result: @escaping (Result<PCMember, Error>) -> Void) {
        guard let imageData = image.pngData() else {
            result(.failure(PCUserServiceError.failedToGetImagePNGRepresentation))
            return
        }
        let parseMember = member.parse
        let imageFile = PFFileObject(name: "image.png", data: imageData)
        parseMember.imageFile = imageFile
        parseMember.saveInBackground { (success, error) in
            if let error = error {
                result(.failure(error))
            } else {
                result(.success(parseMember.pcMember))
            }
        }
    }

    func add(supplier: PCSupplier, result: @escaping ((Result<PCSupplier, Error>) -> Void)) {
        let parseSupplier = supplier.parse
        if let image = supplier.image, let imageData = image.pngData() {
            let imageFile = PFFileObject(name: "image.png", data: imageData)
            parseSupplier.imageFile = imageFile
        }
        parseSupplier.saveInBackground { (succeeded, error) in
            if let error = error {
                result(.failure(error))
            } else {
                result(.success(supplier))
            }

        }
    }

    func add(member: PCMember, in organization: PCOrganization, result: @escaping ((Result<PCMember, Error>) -> Void)) {
        let parseMember = member.parse
        let parseOrganization = organization.parse
        if let image = member.image, let imageData = image.pngData() {
            let imageFile = PFFileObject(name: "image.png", data: imageData)
            parseMember.imageFile = imageFile
        }
        parseMember.saveInBackground { (succeeded, error)  in
            if let error = error {
                result(.failure(error))
            } else {
                if let organizationId = parseOrganization.id, let memberId = parseMember.id {
                    PFCloud.callFunction(inBackground: "applyAsAMemberToOrganization",
                                         withParameters: ["organizationId": organizationId,
                                                          "memberId": memberId]) {
                        (response, error) in
                        if let error = error {
                            result(.failure(error))
                        } else {
                            result(.success(member))
                        }
                    }
                } else {
                    result(.failure(PCUserServiceError.organizationOrUserIdIsNil))
                }
            }
        }
    }

    func add(organization: PCOrganization, result: @escaping ((Result<PCOrganization, Error>) -> Void)) {
        let parseOrganization = organization.parse
        if let image = organization.image, let imageData = image.pngData() {
            let imageFile = PFFileObject(name: "image.png", data: imageData)
            parseOrganization.imageFile = imageFile
        }
        parseOrganization.saveInBackground { (succeeded, error) in
            if let error = error {
                result(.failure(error))
            } else {
                result(.success(organization))
            }
        }
    }
}
