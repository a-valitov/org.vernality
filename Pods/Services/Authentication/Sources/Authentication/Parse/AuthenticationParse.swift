//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/24/20
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
import UserModel

final class AuthenticationParse: Authentication {
    var user: AnyUser? {
        if let phUser = PFUser.current(),
            let id = phUser.objectId,
            let email = phUser.email {
            return UserStruct(id: id, email: email).any
        } else {
            return nil
        }
    }

    func login(email: String,
               password: String,
               parameters: [String: Any]?,
               result: @escaping (Result<AnyUser, Error>) -> Void) {
        let username = (parameters?["username"] as? String) ?? email
        PFUser.logInWithUsername(inBackground: username, password: password) {
          (user: PFUser?, error: Error?) -> Void in
            if let error = error {
                result(.failure(error))
            } else if let user = user, let id = user.objectId {
                let anyUser = UserStruct(id: id, email: email).any
                result(.success(anyUser))
            }
        }
    }

    func register(email: String,
                  password: String,
                  parameters: [String: Any]?,
                  result: @escaping (Result<Bool, Error>) -> Void) {
        let user = PFUser()
        user.username = parameters?["username"] as? String
        user.email = email
        user.password = password
        user.signUpInBackground { (succeeded, error) in
            if let error = error {
                result(.failure(error))
            } else {
                result(.success(succeeded))
            }
        }
    }

    func logout(result: @escaping (Result<Bool, Error>) -> Void) {

    }
}
