//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 22.11.2020
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

import UIKit

final class OnboardSignInViewAlpha: UIViewController {
    var output: OnboardSignInViewOutput?

    var username: String? {
        if self.isViewLoaded {
            return usernameTextField.text
        } else {
            return nil
        }
    }

    var password: String? {
        if self.isViewLoaded {
            return passwordTextField.text
        } else {
            return nil
        }
    }

    private lazy var signInLabel: UILabel = {
        let label = UILabel()
        label.text = "Войти"
        label.font = UIFont(name: "PlayfairDisplay-Regular", size: 36.0)
        label.textColor = #colorLiteral(red: 0.9529411765, green: 0.9176470588, blue: 0.9058823529, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var usernameTextField: UITextField = {
        let username = UITextField()
        username.font = UIFont(name: "Montserrat-Regular", size: 14)
        username.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        username.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 0.2970087757)
        username.layer.cornerRadius = 5
        username.borderStyle = .none
        username.autocorrectionType = .no
        username.spellCheckingType = .no
        username.keyboardType = .emailAddress
        username.returnKeyType = .next
        username.keyboardAppearance = UIKeyboardAppearance.dark
        username.translatesAutoresizingMaskIntoConstraints = false
        return username
    }()

    private lazy var passwordTextField: UITextField = {
        let password = UITextField()
        password.font = UIFont(name: "Montserrat-Regular", size: 14)
        password.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        password.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 0.2970087757)
        password.layer.cornerRadius = 5
        password.borderStyle = .none
        password.autocorrectionType = .no
        password.spellCheckingType = .no
        password.returnKeyType = .done
        password.keyboardAppearance = UIKeyboardAppearance.dark
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()

    private lazy var signInButton: UIButton = {
        let signIn = UIButton()
        signIn.addTarget(self, action: #selector(OnboardSignInViewAlpha.signInButtonTouchUpInside(_:)), for: .touchUpInside)
        signIn.setTitle("Войти", for: .normal)
        signIn.backgroundColor = #colorLiteral(red: 0.9719339013, green: 0.82216537, blue: 0.6347154379, alpha: 1)
        signIn.setTitleColor(#colorLiteral(red: 0.1570591927, green: 0.1517162919, blue: 0.1515991688, alpha: 1), for: .normal)
        signIn.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 15)
        signIn.translatesAutoresizingMaskIntoConstraints = false
        return signIn
    }()

    private lazy var signUpButton: UIButton = {
        let signUp = UIButton()
        signUp.addTarget(self, action: #selector(OnboardSignInViewAlpha.signUpButtonTouchUpInside(_:)), for: .touchUpInside)
        signUp.backgroundColor = .clear
        signUp.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 15)
        signUp.translatesAutoresizingMaskIntoConstraints = false
        return signUp
    }()

    private lazy var resetPassword: UIButton = {
        let resetPassword = UIButton()
        resetPassword.addTarget(self, action: #selector(OnboardSignInViewAlpha.resetPasswordButtonTouchUpInside(_:)), for: .touchUpInside)
        resetPassword.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 12)
        resetPassword.setTitle("Забыли пароль?", for: .normal)
        resetPassword.setTitleColor(#colorLiteral(red: 0.9607843137, green: 0.7843137255, blue: 0.568627451, alpha: 1), for: .normal)
        resetPassword.translatesAutoresizingMaskIntoConstraints = false
        return resetPassword
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        style()

        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    private func setup() {
        view.backgroundColor = .clear
        signUpButton.setAttributedTitle(combination(), for: .normal)

        var blurEffect = UIBlurEffect()
        if #available(iOS 13.0, *) {
            blurEffect = UIBlurEffect(style: .systemMaterialDark)
        } else {
            blurEffect = UIBlurEffect(style: .dark)
        }
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = view.bounds
        self.view.addSubview(blurVisualEffectView)
    }

    private func style() {
        let textColor = UIColor(red: 0.953, green: 0.918, blue: 0.906, alpha: 1)
        let placeholderColor = textColor.withAlphaComponent(0.5)
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Электронная почта", attributes: [.foregroundColor: placeholderColor])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [.foregroundColor: placeholderColor])

        usernameTextField.textColor = textColor
        passwordTextField.textColor = textColor

        usernameTextField.tintColor = textColor
        usernameTextField.tintColor = textColor
    }

    private func combination() -> NSMutableAttributedString {
        let attributesForFirstTitle: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue,
            NSAttributedString.Key.foregroundColor: UIColor(red: 245/255, green: 200/255, blue: 145/255, alpha: 1)
        ]
        let attributesForSecondTitle: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 243/255, green: 234/255, blue: 231/255, alpha: 1)
        ]
        let firstTitle = NSAttributedString(string: "Зарегистрироваться", attributes: attributesForFirstTitle)
        let secondTitle = NSAttributedString(string: "Нет аккаунта? ", attributes: attributesForSecondTitle)

        let combination = NSMutableAttributedString()
        combination.append(secondTitle)
        combination.append(firstTitle)

        return combination
    }

    @objc private func signInButtonTouchUpInside(_ sender: Any) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        self.output?.onboardSignIn(view: self, userWantsToSignIn: sender)
    }

    @objc private func signUpButtonTouchUpInside(_ sender: Any) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        self.output?.onboardSingUp(view: self, userWantsToSignUp: sender)
    }

    @objc private func resetPasswordButtonTouchUpInside(_ sender: Any) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        self.output?.onboardResetPassword(view: self, userWantsToResetPassword: sender)
    }

}

// MARK: - Layout
extension OnboardSignInViewAlpha {
    private func layout() {
        layoutSignInLabel(in: view)
        layoutStack(in: view)
        layoutUsernameTextField(in: stackView)
        layoutPasswordTextField(in: stackView)
        layoutResetPassword(in: view)
        layoutSignIn(in: view)
        layoutSignUp(in: view)
    }

    private func layoutSignInLabel(in container: UIView) {
        let label = signInLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 8.0),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0)
        ])
    }

    private func layoutStack(in container: UIView) {
        let stack = stackView
        container.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 30.0),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0)
        ])
    }

    private func layoutUsernameTextField(in stack: UIStackView) {
        let username = usernameTextField
        NSLayoutConstraint.activate([
            username.heightAnchor.constraint(equalToConstant: 52.0)
        ])
        stack.addArrangedSubview(username)
    }

    private func layoutPasswordTextField(in stack: UIStackView) {
        let password = passwordTextField
        NSLayoutConstraint.activate([
            password.heightAnchor.constraint(equalToConstant: 52.0)
        ])
        stack.addArrangedSubview(password)
    }

    private func layoutResetPassword(in containver: UIView) {
        let reset = resetPassword
        containver.addSubview(reset)
        NSLayoutConstraint.activate([
            reset.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -16.0),
            reset.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 13.0),
            reset.bottomAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: -12.0)
        ])
    }

    private func layoutSignIn(in container: UIView) {
        let signIn = signInButton
        container.addSubview(signIn)
        NSLayoutConstraint.activate([
            signIn.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            signIn.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            signIn.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 25.0),
            signIn.heightAnchor.constraint(equalToConstant: 52.0)
        ])
    }

    private func layoutSignUp(in container: UIView) {
        let signUp = signUpButton
        container.addSubview(signUp)
        NSLayoutConstraint.activate([
            signUp.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 10.0),
            signUp.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            signUp.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            signUp.bottomAnchor.constraint(lessThanOrEqualTo: container.safeAreaLayoutGuide.bottomAnchor, constant: -10.0),
            signUp.heightAnchor.constraint(equalToConstant: 30.0)
        ])
    }
}

// MARK: - UITextFieldDelegate
extension OnboardSignInViewAlpha: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextField:
            passwordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
}

extension OnboardSignInViewAlpha: OnboardSignInViewInput {

}
