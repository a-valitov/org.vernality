//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 18.11.2020
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

final class OnboardSignUpViewAlpha: UIViewController {
    var output: OnboardSignUpViewOutput?

    var email: String? {
        if isViewLoaded {
            return emailTextField.text
        } else {
            return nil
        }
    }
    var password: String? {
        if isViewLoaded {
            return passwordTextField.text
        } else {
            return nil
        }
    }
    var passwordConfirmation: String? {
        if isViewLoaded {
            return passwordConfirmationTextField.text
        } else {
            return nil
        }
    }

    var isOnclick = true

    init() {
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

        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.passwordConfirmationTextField.delegate = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @objc private func signUpButtonTouchUpInside(_ sender: Any) {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.passwordConfirmationTextField.resignFirstResponder()
        self.output?.onboardSignUp(view: self, userWantsToSignUp: sender)
    }

    @objc private func signInButtonTouchUpInside(_ sender: Any) {
        self.output?.onboardSignIn(view: self, userWantsToSignIp: sender)
    }

    private func setup() {
        view.backgroundColor = .clear
        signUpButton.addTarget(self, action: #selector(OnboardSignUpViewAlpha.signUpButtonTouchUpInside(_:)), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(OnboardSignUpViewAlpha.signInButtonTouchUpInside(_:)), for: .touchUpInside)

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

    private func localize() {
        signUpButton.setTitle("Зарегистрироваться", for: .normal)
        registrationLabel.text = "Регистрация"
    }

    private func style() {
        signUpButton.backgroundColor = #colorLiteral(red: 0.9719339013, green: 0.82216537, blue: 0.6347154379, alpha: 1)
        signUpButton.setTitleColor(#colorLiteral(red: 0.1570591927, green: 0.1517162919, blue: 0.1515991688, alpha: 1), for: .normal)
        signUpButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 15)

        signInButton.backgroundColor = .clear
        signInButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 15)
        signInButton.setAttributedTitle(combination(), for: .normal)

        registrationLabel.font = UIFont(name: "PlayfairDisplay-Regular", size: 36.0)
        registrationLabel.textColor = #colorLiteral(red: 0.9632286429, green: 0.9344153404, blue: 0.9245409369, alpha: 1)

        self.emailTextField.font = UIFont(name: "Montserrat-Regular", size: 14)
        self.passwordTextField.font = UIFont(name: "Montserrat-Regular", size: 14)
        self.passwordConfirmationTextField.font = UIFont(name: "Montserrat-Regular", size: 14)

        self.passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        self.passwordConfirmationTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        self.emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)

        let textColor = UIColor(red: 0.953, green: 0.918, blue: 0.906, alpha: 1)
        let placeholderColor = textColor.withAlphaComponent(0.5)
        self.emailTextField.attributedPlaceholder = NSAttributedString(string: "Электронная почта",
                                                                       attributes:[.foregroundColor: placeholderColor])
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Пароль",
                                                                          attributes:[.foregroundColor: placeholderColor])
        self.passwordConfirmationTextField.attributedPlaceholder = NSAttributedString(string: "Подтверждение пароля",
                                                                                      attributes:[.foregroundColor: placeholderColor])
        self.emailTextField.tintColor = textColor
        self.passwordTextField.tintColor = textColor
        self.passwordConfirmationTextField.tintColor = textColor

        self.emailTextField.textColor = textColor
        self.passwordTextField.textColor = textColor
        self.passwordConfirmationTextField.textColor = textColor

        self.emailTextField.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 0.3)
        self.passwordTextField.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 0.3)
        self.passwordConfirmationTextField.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 0.3)

        self.emailTextField.layer.cornerRadius = 5
        self.passwordTextField.layer.cornerRadius = 5
        self.passwordConfirmationTextField.layer.cornerRadius = 5

        self.emailTextField.autocorrectionType = UITextAutocorrectionType.no
        self.passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        self.passwordConfirmationTextField.autocorrectionType = UITextAutocorrectionType.no

        self.emailTextField.autocapitalizationType = .none
        self.passwordTextField.autocapitalizationType = .none
        self.passwordConfirmationTextField.autocapitalizationType = .none

        self.emailTextField.spellCheckingType = .no
        self.passwordTextField.spellCheckingType = .no
        self.passwordConfirmationTextField.spellCheckingType = .no

        self.emailTextField.keyboardType = .emailAddress
        self.emailTextField.autocapitalizationType = .none
        self.emailTextField.returnKeyType = .next
        self.passwordTextField.returnKeyType = .next
        self.passwordConfirmationTextField.returnKeyType = .done

        self.passwordTextField.textContentType = .password
        self.passwordConfirmationTextField.textContentType = .password

        self.emailTextField.keyboardAppearance = UIKeyboardAppearance.dark
        self.passwordTextField.keyboardAppearance = UIKeyboardAppearance.dark
        self.passwordConfirmationTextField.keyboardAppearance = UIKeyboardAppearance.dark

        self.passwordTextField.isSecureTextEntry = true
        self.passwordConfirmationTextField.isSecureTextEntry = true

        self.showHidePasswordButton.addTarget(self, action: #selector(OnboardSignUpViewAlpha.toggleShowHide(button:)), for: .touchUpInside)
        self.showHidePasswordButton.setImage(#imageLiteral(resourceName: "showPassword").withRenderingMode(.alwaysTemplate), for: .normal)
        self.showHidePasswordButton.setImage(#imageLiteral(resourceName: "hidePassword").withRenderingMode(.alwaysTemplate), for: .selected)
        self.showHidePasswordButton.tintColor = #colorLiteral(red: 0.1588078997, green: 0.1588078997, blue: 0.1588078997, alpha: 1)
    }

    @objc private func toggleShowHide(button: UIButton) {
        button.isSelected.toggle()
        if isOnclick {
            self.passwordTextField.isSecureTextEntry = false
        } else {
            self.passwordTextField.isSecureTextEntry = true
        }

        isOnclick = !isOnclick
    }

    private func combination() -> NSMutableAttributedString {
        let attributesForTitle1: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue,
            NSAttributedString.Key.foregroundColor: UIColor(red: 245/255, green: 200/255, blue: 145/255, alpha: 1)
        ]
        let attributesForTitle2: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 243/255, green: 234/255, blue: 231/255, alpha: 1)
        ]
        let title1 = NSAttributedString(string: "Войти", attributes: attributesForTitle1)
        let title2 = NSAttributedString(string: "Уже есть аккаунт? ", attributes: attributesForTitle2)

        let combination = NSMutableAttributedString()
        combination.append(title2)
        combination.append(title1)

        return combination
    }

    private let registrationLabel = UILabel()
    private let stackView = UIStackView()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let passwordConfirmationTextField = UITextField()
    private let signUpButton = UIButton()
    private let signInButton = UIButton()
    private let showHidePasswordButton = UIButton()
}

extension OnboardSignUpViewAlpha {
    private func layout() {
        layoutRegistrationLabel(in: view)
        layoutStack(in: view)
        layoutEmailTextField(in: stackView)
        layoutPasswordTextField(in: stackView)
        layoutShowHidePasswordButton(in: view)
        layoutPasswordConfirmationTextField(in: stackView)
        layoutSignUp(in: view)
        layoutSignIn(in: view)
    }

    private func layoutRegistrationLabel(in container: UIView) {
        let label = registrationLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20)
        ])
    }

    private func layoutStack(in container: UIView) {
        let stack = stackView
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 15
        container.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: registrationLabel.bottomAnchor, constant: 30),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20)
        ])
    }

    private func layoutEmailTextField(in stack: UIStackView) {
        let email = emailTextField
        email.translatesAutoresizingMaskIntoConstraints = false
        email.borderStyle = .none
        NSLayoutConstraint.activate([
            email.heightAnchor.constraint(equalToConstant: 52.0)
        ])
        stack.addArrangedSubview(email)
    }

    private func layoutPasswordTextField(in stack: UIStackView) {
        let password = passwordTextField
        password.translatesAutoresizingMaskIntoConstraints = false
        password.borderStyle = .none
        NSLayoutConstraint.activate([
            password.heightAnchor.constraint(equalToConstant: 52.0)
        ])
        stack.addArrangedSubview(password)
    }

    private func layoutShowHidePasswordButton(in container: UIView) {
        let showHide = showHidePasswordButton
        showHide.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(showHide)
        NSLayoutConstraint.activate([
            showHide.widthAnchor.constraint(equalToConstant: 30.0),
            showHide.heightAnchor.constraint(equalToConstant: 30.0),
            showHide.topAnchor.constraint(equalTo: self.passwordTextField.topAnchor, constant: 10.0),
            showHide.trailingAnchor.constraint(equalTo: self.passwordTextField.trailingAnchor, constant: -10.0)
        ])
    }

    private func layoutPasswordConfirmationTextField(in stack: UIStackView) {
        let passwordConfirmation = passwordConfirmationTextField
        passwordConfirmation.translatesAutoresizingMaskIntoConstraints = false
        passwordConfirmation.borderStyle = .none
        NSLayoutConstraint.activate([
            passwordConfirmation.heightAnchor.constraint(equalToConstant: 52.0)
        ])
        stack.addArrangedSubview(passwordConfirmation)
    }

    private func layoutSignUp(in container: UIView) {
        let signUp = signUpButton
        container.addSubview(signUp)
        signUp.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUp.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            signUp.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            signUp.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 25.0),
            signUp.heightAnchor.constraint(equalToConstant: 52.0)
        ])
    }

    private func layoutSignIn(in container: UIView) {
        let signIn = signInButton
        container.addSubview(signIn)
        signIn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signIn.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 10.0),
            signIn.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            signIn.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            signIn.heightAnchor.constraint(equalToConstant: 30.0),
            signIn.bottomAnchor.constraint(lessThanOrEqualTo: container.safeAreaLayoutGuide.bottomAnchor, constant: -10.0)
        ])
    }

}

extension OnboardSignUpViewAlpha: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordConfirmationTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
}

extension OnboardSignUpViewAlpha: OnboardSignUpViewInput {
    func finishAlert() {
        var blurEffect = UIBlurEffect()
        blurEffect = UIBlurEffect(style: .dark)
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = view.bounds
        self.view.addSubview(blurVisualEffectView)

        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)

        let backView = alertController.view.subviews.first?.subviews.first?.subviews.first
        backView?.layer.cornerRadius = 14.0
        backView?.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 0.7476990582)

        let titleFont = [NSAttributedString.Key.foregroundColor: UIColor(red: 241/255, green: 231/255, blue: 228/255, alpha: 1)]
        let messageFont = [NSAttributedString.Key.foregroundColor: UIColor(red: 241/255, green: 231/255, blue: 228/255, alpha: 1)]
        let attributedTitle = NSAttributedString(string: "Вы прошли регистрацию", attributes: titleFont)
        let attributedMessage = NSAttributedString(string: "Осталось выбрать роль в клубе", attributes: messageFont)

        alertController.setValue(attributedTitle, forKey: "attributedTitle")
        alertController.setValue(attributedMessage, forKey: "attributedMessage")

        let okAction = UIAlertAction(title: "Продолжить", style: .default) { [weak self] action in
            guard let sSelf = self else { return }
            sSelf.output?.onboardFinishSignUp(view: sSelf, userWantsToSignUp: action)
            blurVisualEffectView.removeFromSuperview()
        }
        okAction.setValue(UIColor(red: 245/255, green: 200/255, blue: 145/255, alpha: 1), forKey: "titleTextColor")

        alertController.addAction(okAction)
        alertController.preferredAction = okAction
        present(alertController, animated: true)
    }
}
