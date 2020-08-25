//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/21/20
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
import RealmManager
import UserModel
import RealmSwift

final class AuthenticationRealmApp: Authentication {
    var user: AnyUser? {
        if let user = self.realmManager.app.currentUser(),
            let id = user.identity {
            return UserStruct(id: id, email: nil).any
        } else {
            return nil
        }
    }
    init(realmManager: RealmManager) {
        self.realmManager = realmManager
    }

    func login(email: String,
               password: String,
               parameters: [String: Any]?,
               result: @escaping (Result<AnyUser, Error>) -> Void) {
        self.realmManager.app.login(withCredential: AppCredentials(username: email, password: password)) { [weak self] (user, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        result(.failure(error))
                    }
                } else if let user = user, let id = user.identity {
                    DispatchQueue.main.async { [weak self] in
                        do {
                            try self?.realmManager.authorize()
                            result(.success(UserStruct(id: id, email: email).any))
                        } catch {
                            result(.failure(error))
                        }

                    }
                }
            }

    }

    func register(email: String,
                  password: String,
                  parameters: [String: Any]?,
                  result: @escaping (Result<Bool, Error>) -> Void) {
        self.realmManager.app.usernamePasswordProviderClient().registerEmail(email, password: password, completion: { error in
            DispatchQueue.main.async {
                if let error = error {
                    result(.failure(error))
                } else {
                    result(.success(true))
                }
            }
        })
    }

    func logout(result: @escaping (Result<Bool, Error>) -> Void) {
        self.realmManager.app.logOut(completion: { error in
            DispatchQueue.main.async {
                if let error = error {
                    result(.failure(error))
                } else {
                    result(.success(true))
                }
            }
        })
    }

    private let realmManager: RealmManager
}
