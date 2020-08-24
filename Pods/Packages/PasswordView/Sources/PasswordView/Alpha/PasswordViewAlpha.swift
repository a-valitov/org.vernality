//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/23/20
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
import UIKit

extension PasswordViewAlpha: PasswordViewInput {
}

final class PasswordViewAlpha: UIViewController {
    init(passwordHint: String?, output: PasswordViewOutput) {
        self.passwordHint = passwordHint
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
        self.localize()
        self.style()
        self.update()
    }

    private func setup() {
        self.passwordTextField.autocorrectionType = .no
        self.passwordTextField.autocapitalizationType = .none
        self.passwordTextField.isSecureTextEntry = true
        self.submitButton.addTarget(self, action: #selector(PasswordViewAlpha.submitButtonTouchUpInside(_:)), for: .touchUpInside)
    }

    @objc
    private func submitButtonTouchUpInside(_ sender: Any) {
        guard let password = self.passwordTextField.text else { return }
        self.output.password(view: self, didEnter: password)
    }

    private func layout() {
        self.layoutStack(in: self.view)
        self.layoutPasswordHint(in: self.stackView)
        self.layoutPassword(in: self.stackView)
        self.layoutSubmit(in: self.stackView)
    }

    private func layoutSubmit(in stack: UIStackView) {
        let submit = self.submitButton
        submit.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(submit)
    }

    private func layoutPassword(in stack: UIStackView) {
        let password = self.passwordTextField
        password.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(password)
    }

    private func layoutPasswordHint(in stack: UIStackView) {
        let passwordHint = self.passwordHintLabel
        passwordHint.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(passwordHint)
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
            stack.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            container.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 20),
            container.safeAreaLayoutGuide.bottomAnchor.constraint(greaterThanOrEqualTo: stack.bottomAnchor, constant: 60),
            stack.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 40)
        ])
    }

    private func localize() {
        self.submitButton.setTitle("Submit", for: .normal)
    }

    private func style() {
        self.view.backgroundColor = .white
        self.submitButton.setTitleColor(.red, for: .normal)
        self.passwordTextField.borderStyle = .line
    }

    private func update() {
        self.updatePasswordHint()
    }

    private func updatePasswordHint() {
        if self.isViewLoaded {
            self.passwordHintLabel.text = self.passwordHint
        }
    }

    private let passwordHint: String?
    private let output: PasswordViewOutput
    private let stackView = UIStackView()
    private let passwordHintLabel = UILabel()
    private let passwordTextField = UITextField()
    private let submitButton = UIButton()
}

#endif
