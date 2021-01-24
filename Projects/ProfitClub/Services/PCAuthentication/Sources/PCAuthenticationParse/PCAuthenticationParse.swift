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
import PCModel

final class PCAuthenticationParse: PCAuthentication {
    func login(username: String, password: String, result: @escaping ((Result<AnyPCUser, Error>) -> Void)) {
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if let error = error {
                result(.failure(error))
            } else if let user = user, let anyUser = user.pcUser?.any {
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
