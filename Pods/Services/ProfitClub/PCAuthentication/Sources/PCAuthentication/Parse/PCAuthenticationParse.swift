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
            } else if let user = user, let anyUser = user.pcUser?.any {
                self?.user = anyUser
                PFInstallation.current()?.setObject(user, forKey: "user")
                PFInstallation.current()?.saveEventually()
                result(.success(anyUser))
            } else {
                result(.failure(PCAuthenticationError.bothResultAndErrorAreNil))
            }
        }
    }

    func resetPassword(email: String, result: @escaping ((Result<Bool, Error>) -> Void)) {
        PFUser.requestPasswordResetForEmail(inBackground: email) { (succeeded, error) in
            if let error = error {
                result(.failure(error))
            } else {
                result(.success(succeeded))
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
                    result(.failure(PCAuthenticationError.organizationOrUserIdIsNil))
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

    func register(user: PCUser, password: String, result: @escaping ((Result<AnyPCUser, Error>) -> Void)) {
        let parseUser = user.parse
        parseUser.password = password
        parseUser.signUpInBackground { (success, error) in
            if let error = error {
                result(.failure(error))
            } else {
                let defaultACL = PFACL(user: parseUser)
                defaultACL.setReadAccess(true, forRoleWithName: PCRole.administrator.rawValue)
                PFACL.setDefault(defaultACL, withAccessForCurrentUser: true)
                PFInstallation.current()?.setObject(parseUser, forKey: "user")
                PFInstallation.current()?.saveEventually()
                result(.success(user.any))
            }
        }
    }
}
