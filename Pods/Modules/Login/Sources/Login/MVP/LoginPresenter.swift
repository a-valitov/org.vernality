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
import UserModel
import Authentication
import ErrorPresenter
import ActivityPresenter

final class LoginPresenter {
    weak var view: LoginViewInput?
    weak var output: LoginModuleOutput?

    init(authentication: Authentication,
         errorPresenter: ErrorPresenter,
         activityPresenter: ActivityPresenter) {
        self.authentication = authentication
        self.errorPresenter = errorPresenter
        self.activityPresenter = activityPresenter
    }

    private let errorPresenter: ErrorPresenter
    private let activityPresenter: ActivityPresenter
    private let authentication: Authentication
}

extension LoginPresenter: LoginModule {
}

extension LoginPresenter: LoginViewOutput {
    func userWantsToLogin(email: String?, password: String?) {
        guard let email = email, email.isEmpty == false else {
            self.errorPresenter.present(LoginError.emailIsEmpty)
            return
        }
        guard let password = password, password.isEmpty == false else {
            self.errorPresenter.present(LoginError.passwordIsEmpty)
            return
        }
        self.login(email: email, password: password)
    }

    func userWantsToRegister(email: String?, password: String?) {
        guard let email = email, email.isEmpty == false else {
            self.errorPresenter.present(LoginError.emailIsEmpty)
            return
        }
        guard let password = password, password.isEmpty == false else {
            self.errorPresenter.present(LoginError.passwordIsEmpty)
            return
        }
        self.activityPresenter.increment()
        self.authentication.register(email: email, password: password) { [weak self] result in
            guard let sSelf = self else { return }
            sSelf.activityPresenter.decrement()
            switch result {
            case .success:
                sSelf.login(email: email, password: password)
            case .failure(let error):
                sSelf.errorPresenter.present(error)
            }
        }
    }
}

extension LoginPresenter {
    private func login(email: String, password: String) {
        self.activityPresenter.increment()
        self.authentication.login(email: email, password: password) { [weak self] result in
            guard let sSelf = self else { return }
            sSelf.activityPresenter.decrement()
            switch result {
            case .success(let user):
                sSelf.output?.login(module: sSelf, loggedIn: user)
            case .failure(let error):
                sSelf.errorPresenter.present(error)
            }
        }
    }
}
