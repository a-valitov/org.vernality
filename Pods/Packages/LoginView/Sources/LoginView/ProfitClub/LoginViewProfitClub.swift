//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/25/20
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

#if canImport(UIKit)
import Foundation
import UIKit

final class LoginViewControllerProfitClub: UIViewController {
    var output: LoginViewOutput
    var email: String? {
        get {
            return self.emailTextField.text
        }
        set {
            self.emailTextField.text = newValue
        }
    }
    var password: String? {
        get {
            return self.passwordTextField.text
        }
        set {
            self.passwordTextField.text = newValue
        }
    }
    var parameters: [String: Any]? {
        var result = [String: Any]()
        if let username = self.usernameTextField.text {
            result["username"] = username
        }
        return result
    }

    init(output: LoginViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.layout()
        self.style()
        self.localize()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private let stackView = UIStackView()
    private let emailTextField = UITextField()
    private let usernameTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton()
    private let registerButton = UIButton()

    private func style() {
        self.view.backgroundColor = .white
        self.loginButton.setTitleColor(.black, for: .normal)
        self.registerButton.setTitleColor(.black, for: .normal)
    }

    private func localize() {
        self.emailTextField.placeholder = "Email"
        self.passwordTextField.placeholder = "Password"
        self.usernameTextField.placeholder = "Username"
        self.loginButton.setTitle("Login", for: .normal)
        self.registerButton.setTitle("Register", for: .normal)
    }

    private func setup() {
        self.emailTextField.keyboardType = .emailAddress
        self.emailTextField.autocapitalizationType = .none
        self.emailTextField.autocorrectionType = .no
        self.passwordTextField.isSecureTextEntry = true
        self.passwordTextField.autocapitalizationType = .none
        self.passwordTextField.autocorrectionType = .no
        self.usernameTextField.keyboardType = .asciiCapable
        self.usernameTextField.autocapitalizationType = .none
        self.usernameTextField.autocorrectionType = .no
        self.loginButton.addTarget(self, action: #selector(LoginViewControllerProfitClub.loginButtonTouchUpInside(_:)), for: .touchUpInside)
        self.registerButton.addTarget(self, action: #selector(LoginViewControllerProfitClub.registerButtonTouchUpInside(_:)), for: .touchUpInside)
    }

    @objc
    private func loginButtonTouchUpInside(_ sender: Any) {
        self.output.loginViewUserWantsToLogin(self)
    }

    @objc
    private func registerButtonTouchUpInside(_ sender: Any) {
        self.output.loginViewUserWantsToRegister(self)
    }
}

extension LoginViewControllerProfitClub: LoginViewInput {
}

// MARK: - Layout
extension LoginViewControllerProfitClub {
    private func layout() {
        self.layoutStack(in: self.view)
        self.layoutEmail(in: self.stackView)
        self.layoutUsername(in: self.stackView)
        self.layoutPassword(in: self.stackView)
        self.layoutLogin(in: self.stackView)
        self.layoutRegister(in: self.stackView)
    }

    private func layoutUsername(in stack: UIStackView) {
        let username = self.usernameTextField
        username.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(username)
    }

    private func layoutEmail(in stack: UIStackView) {
        let email = self.emailTextField
        email.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(email)
    }

    private func layoutPassword(in stack: UIStackView) {
        let password = self.passwordTextField
        password.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(password)
    }

    private func layoutLogin(in stack: UIStackView) {
        let login = self.loginButton
        login.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(login)
    }

    private func layoutRegister(in stack: UIStackView) {
        let register = self.registerButton
        register.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(register)
    }

    private func layoutStack(in container: UIView) {
        let stack = self.stackView
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 16
        self.view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            container.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 20)
        ])
    }
}
#endif
