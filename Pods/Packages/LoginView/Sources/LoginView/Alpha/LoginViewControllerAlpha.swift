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

#if canImport(UIKit)
import Foundation
import UIKit

final class LoginViewControllerAlpha: UIViewController {
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
    var parameters: [String: Any]? = nil

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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()

    private func setup() {
        guard let container = self.view else { return }
        container.backgroundColor = .white

        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 16
        self.view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 20)
        ])


        self.emailTextField.keyboardType = .emailAddress
        self.emailTextField.autocapitalizationType = .none
        self.emailTextField.placeholder = "Email"
        stack.addArrangedSubview(self.emailTextField)

        self.passwordTextField.isSecureTextEntry = true
        self.passwordTextField.autocapitalizationType = .none
        self.passwordTextField.placeholder = "Password"
        stack.addArrangedSubview(self.passwordTextField)

        let login = UIButton()
        login.setTitle("Login", for: .normal)
        login.setTitleColor(.black, for: .normal)
        stack.addArrangedSubview(login)
        login.addTarget(self, action: #selector(LoginViewControllerAlpha.loginButtonTouchUpInside(_:)), for: .touchUpInside)


        let register = UIButton()
        register.setTitle("Register", for: .normal)
        register.setTitleColor(.black, for: .normal)
        stack.addArrangedSubview(register)
        register.addTarget(self, action: #selector(LoginViewControllerAlpha.registerButtonTouchUpInside(_:)), for: .touchUpInside)
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

extension LoginViewControllerAlpha: LoginViewInput {
}

#endif
