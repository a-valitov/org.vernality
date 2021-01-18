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
import Main
import ErrorPresenter
import ActivityPresenter
import ConfirmationPresenter
import ProfitClubModel

final class OnboardPresenter: OnboardModule {
    weak var output: OnboardModuleOutput?
//    var router: OnboardRouter?
    var viewController: UIViewController {
        return self.welcome
    }

    init(presenters: OnboardPresenters,
         services: OnboardServices) {
        self.presenters = presenters
        self.services = services
    }
    
    // dependencies
    private let presenters: OnboardPresenters
    private let services: OnboardServices

    // views
    private var welcome: UIViewController {
        if let welcome = self.weakWelcome {
            return welcome
        } else {
            let welcome = OnboardWelcomeViewAlpha()
            welcome.output = self
            self.weakWelcome = welcome
            return welcome
        }
    }
    private var signIn: UIViewController {
        if let signIn = self.weakSignIn {
            return signIn
        } else {
            let signIn = OnboardSignInViewAlpha()
            signIn.output = self
            self.weakSignIn = signIn
            return signIn
        }
    }
    private var signUp: UIViewController {
        if let signUp = self.weakSignUp {
            return signUp
        } else {
            let signUp = OnboardSignUpViewAlpha()
            signUp.output = self
            self.weakSignUp = signUp
            return signUp
        }
    }
    private var resetPassword: UIViewController {
        if let resetPassword = self.weakResetPassword {
            return resetPassword
        } else {
            let resetPassword = OnboardResetPasswordViewAlpha()
            resetPassword.output = self
            self.weakResetPassword = resetPassword
            return resetPassword
        }
    }

    private weak var weakWelcome: UIViewController?
    private weak var weakSignIn: UIViewController?
    private weak var weakSignUp: UIViewController?
    private weak var weakResetPassword: UIViewController?

    // persisted
    private var email: String?
    private var password: String?
}

extension OnboardPresenter: OnboardWelcomeViewOutput {
    func onboardWelcome(view: OnboardWelcomeViewInput, userWantsToSignIn sender: Any) {
        view.raise(self.signIn, animated: true)
    }

    func onboardWelcome(view: OnboardWelcomeViewInput, userWantsToSignUp sender: Any) {
        view.raise(self.signUp, animated: true)
    }
}

extension OnboardPresenter: OnboardSignInViewOutput {
    func onboardSignIn(view: OnboardSignInViewInput, userWantsToSignIn sender: Any) {
        guard let password = view.password, password.isEmpty == false else {
            self.presenters.error.present(OnboardError.passwordIsEmpty)
            return
        }
        guard let username = view.username, username.isEmpty == false else {
            self.presenters.error.present(OnboardError.usernameIsEmpty)
            return
        }
        self.presenters.activity.increment()
        self.services.authentication.login(username: username, password: password) { [weak self] result in
            guard let sSelf = self else { return }
            sSelf.presenters.activity.decrement()
            switch result {
            case .success(let user):
                view.unraise(animated: true, completion: { [weak sSelf] in
                    guard let ssSelf = sSelf else { return }
                    ssSelf.output?.onboard(module: ssSelf, didLogin: user)
                })
            case .failure(let error):
                sSelf.presenters.error.present(error)
            }
        }
    }

    func onboardSingUp(view: OnboardSignInViewInput, userWantsToSignUp sender: Any) {
        let presenting = view.presentingViewController
        view.unraise(animated: true, completion: { [weak self] in
            guard let sSelf = self else { return }
            presenting?.raise(sSelf.signUp, animated: true)
        })
    }

    func onboardResetPassword(view: OnboardSignInViewInput, userWantsToResetPassword sender: Any) {
        let presenting = view.presentingViewController
        view.unraise(animated: true, completion: { [weak self] in
            guard let sSelf = self else { return }
            presenting?.raise(sSelf.resetPassword, animated: true)
        })
    }
}

extension OnboardPresenter: OnboardSignUpViewOutput {
    func onboardSignUp(view: OnboardSignUpViewInput, userWantsToSignUp sender: Any) {
        guard let email = view.email, email.isEmpty == false else {
            self.presenters.error.present(OnboardError.emailIsEmpty)
            return
        }
        guard let password = view.password, password.isEmpty == false else {
            self.presenters.error.present(OnboardError.passwordIsEmpty)
            return
        }
        guard let passwordConfirmation = view.passwordConfirmation, passwordConfirmation.isEmpty == false else {
            self.presenters.error.present(OnboardError.passwordIsEmpty)
            return
        }
        guard password == passwordConfirmation else {
            self.presenters.error.present(OnboardError.passwordNotMatchConfirmation)
            return
        }
        self.email = email
        self.password = password
        if let user = self.createUser() {
            self.presenters.activity.decrement()
            self.services.authentication.register(user: user, password: password) { [weak self] (result) in
                guard let sSelf = self else { return }
                switch result {
                case .success:
                    view.unraise(animated: true) { [weak sSelf] in
                        guard let ssSelf = sSelf else { return }
                        ssSelf.presenters.confirmation.present(
                            title: "Вы прошли регистрацию",
                            message: "Осталось выбрать роль в клубе",
                            actionTitle: "Продолжить",
                            withCancelAction: false,
                            completion: { [weak ssSelf] in
                                guard let sssSelf = ssSelf else { return }
                                sssSelf.output?.onboard(module: sssSelf, didRegister: user)
                            }
                        )
                    }
                case .failure(let error):
                    sSelf.presenters.error.present(error)
                }
            }
        }
    }

    func onboardSignIn(view: OnboardSignUpViewInput, userWantsToSignIp sender: Any) {
        let presenting = view.presentingViewController
        view.unraise(animated: true, completion: { [weak self] in
            guard let sSelf = self else { return }
            presenting?.raise(sSelf.signIn, animated: true)
        })
    }
}

extension OnboardPresenter: OnboardResetPasswordViewOutput {
    func onboardResetPasswordDidFinish(view: OnboardResetPasswordViewInput) {
        guard let email = view.email, email.isEmpty == false else {
            self.presenters.error.present(OnboardError.emailIsEmpty)
            return
        }
        self.email = email
        if self.isValid(email: email) {
            self.presenters.activity.increment()
            self.services.authentication.resetPassword(email: email) { [weak self] result in
                guard let sSelf = self else { return }
                sSelf.presenters.activity.decrement()
                switch result {
                case .success:
                    view.unraise(animated: true) { [weak sSelf] in
                        sSelf?.presenters.confirmation.present(
                            title: "Вы сбросили пароль",
                            message: "Проверьте вашу почту",
                            actionTitle: "Спасибо",
                            withCancelAction: false
                        )
                    }
                case .failure(let error):
                    self?.presenters.error.present(error)
                }
            }
        } else {
            self.presenters.confirmation.present(
                title: "Некорректный email",
                message: "Пожалуйста, проверьте email",
                actionTitle: "Хорошо",
                withCancelAction: false
            )
        }
    }
}

extension OnboardPresenter {
    private func createUser() -> PCUserStruct? {
        guard let email = self.email, email.isEmpty == false else {
            return nil
        }
        var user = PCUserStruct()
        user.username = email
        user.email = email
        return user
    }

    private func isValid(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}

