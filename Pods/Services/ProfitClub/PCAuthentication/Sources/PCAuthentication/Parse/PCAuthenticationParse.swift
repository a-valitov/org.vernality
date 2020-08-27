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

final class PCAuthenticationParse: PCAuthentication {
    var user: AnyPCUser? {
        return nil
    }

    func register(user: PCUser, password: String, result: @escaping ((Result<AnyPCUser, Error>) -> Void)) {
        let group = DispatchGroup()
        var finalError: Error?
        let pfUser = PFUser()
        pfUser.username = user.username
        pfUser.password = password
        pfUser.email = user.email
        group.enter()
        pfUser.signUpInBackground { (success, error) in
            if success {
                let defaultACL = PFACL(user: pfUser)
                defaultACL.setReadAccess(true, forRoleWithName: PCRole.administratior.rawValue)
                PFACL.setDefault(defaultACL, withAccessForCurrentUser: true)
            }
            for role in user.roles {
                switch role {
                case .supplier:
                    if let supplier = user.supplier {
                        let pfSupplier = PFObject(className: "Supplier")
                        pfSupplier["name"] = supplier.name
                        pfSupplier["inn"] = supplier.inn
                        pfSupplier["phone"] = supplier.phone
                        pfSupplier["contact"] = supplier.contact
                        group.enter()
                        pfSupplier.saveInBackground { (succeeded, error)  in
                            if let error = error {
                                finalError = error
                            }
                            group.leave()
                        }
                    } else {
                        assertionFailure()
                    }
                default:
                    assertionFailure("not implemented yet")
                }
            }
            if let error = error {
                finalError = error
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
