//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 23.11.2020
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

final class OnboardResetPasswordViewAlpha: UIViewController {
    var output: OnboardResetPasswordViewOutput?

    var email: String? {
        if isViewLoaded {
            return emailTextField.text
        } else {
            return nil
        }
    }
    var keyboardIsShown = false
    private var resetPasswordButtonBottomToContainerBottomConstraint: NSLayoutConstraint!

    private lazy var resetPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Сбросить пароль"
        label.font = UIFont(name: "PlayfairDisplay-Regular", size: 36.0)
        label.textColor = #colorLiteral(red: 0.9529411765, green: 0.9176470588, blue: 0.9058823529, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Укажите почту, которую Вы использовали для входа в приложение"
        label.font = UIFont(name: "Montserrat-Regular", size: 16.0)
        label.textColor = #colorLiteral(red: 0.9529411765, green: 0.9176470588, blue: 0.9058823529, alpha: 1)
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var emailTextField: UITextField = {
        let email = UITextField()
        email.font = UIFont(name: "Montserrat-Regular", size: 14.0)
        email.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        email.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 0.3)
        email.layer.cornerRadius = 5
        email.autocorrectionType = .no
        email.spellCheckingType = .no
        email.keyboardType = .emailAddress
        email.returnKeyType = .done
        email.keyboardAppearance = .dark
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()

    private lazy var resetPasswordButton: UIButton = {
        let resetPassword = UIButton()
        resetPassword.addTarget(self, action: #selector(OnboardResetPasswordViewAlpha.resetPasswordButtonTouchUpInside(_:)), for: .touchUpInside)
        resetPassword.setTitle("Сбросить", for: .normal)
        resetPassword.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.7843137255, blue: 0.568627451, alpha: 1)
        resetPassword.setTitleColor(#colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09411764706, alpha: 1), for: .normal)
        resetPassword.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 15.0)
        resetPassword.translatesAutoresizingMaskIntoConstraints = false
        return resetPassword
    }()

    private lazy var backgroundImageView: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.image = #imageLiteral(resourceName: "onboard-welcome-bg")
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImage
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

        emailTextField.delegate = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    private func setup() {
        view.backgroundColor = .clear
        navigationItem.title = "Сбросить пароль"

        var blurEffect = UIBlurEffect()
        if #available(iOS 13.0, *) {
            blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        } else {
            blurEffect = UIBlurEffect(style: .dark)
        }
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = view.bounds
        self.backgroundImageView.addSubview(blurVisualEffectView)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func style() {
        let textColor = UIColor(red: 0.953, green: 0.918, blue: 0.906, alpha: 1)
        let placeholderColor = textColor.withAlphaComponent(0.5)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Электронная почта",
                                                                  attributes: [.foregroundColor: placeholderColor])

        emailTextField.tintColor = textColor
        emailTextField.textColor = textColor
    }

    @objc private func resetPasswordButtonTouchUpInside(_ sender: Any) {
        emailTextField.resignFirstResponder()
        self.output?.onboardResetPasswordDidFinish(view: self)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if !keyboardIsShown {
            guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
            resetPasswordButtonBottomToContainerBottomConstraint.constant = -10 - keyboardSize.height
            keyboardIsShown = true
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if keyboardIsShown {
            resetPasswordButtonBottomToContainerBottomConstraint.constant = -20
            keyboardIsShown = false
        }
    }
}

// MARK: - Layout
extension OnboardResetPasswordViewAlpha {
    private func layout() {
        layoutBackgroundImage(in: view)
        layoutResetPasswordLabel(in: view)
        layoutDescriptionLabel(in: view)
        layoutEmailTextField(in: view)
        layoutResetPasswordButton(in: view)
    }

    private func layoutBackgroundImage(in container: UIView) {
        let backgroudImage = backgroundImageView
        container.addSubview(backgroudImage)
        NSLayoutConstraint.activate([
            backgroudImage.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            backgroudImage.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0),
            backgroudImage.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            backgroudImage.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0)
        ])
    }

    private func layoutResetPasswordLabel(in container: UIView) {
        let label = resetPasswordLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0)
        ])
    }

    private func layoutDescriptionLabel(in container: UIView) {
        let label = descriptionLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: resetPasswordLabel.bottomAnchor, constant: 15.0),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0)
        ])
    }

    private func layoutEmailTextField(in container: UIView) {
        let email = emailTextField
        container.addSubview(email)
        NSLayoutConstraint.activate([
            email.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30.0),
            email.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            email.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            email.heightAnchor.constraint(equalToConstant: 48.0)
        ])
    }

    private func layoutResetPasswordButton(in container: UIView) {
        let button = resetPasswordButton
        container.addSubview(button)
        resetPasswordButtonBottomToContainerBottomConstraint = button.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor, constant: -20.0)
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            button.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            resetPasswordButtonBottomToContainerBottomConstraint,
            button.heightAnchor.constraint(equalToConstant: 52.0)
        ])
    }
}

// MARK: - UITextFieldDelegate
extension OnboardResetPasswordViewAlpha: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension OnboardResetPasswordViewAlpha: OnboardResetPasswordViewInput {
    func alert() {
        let alertController = UIAlertController(title: "Invalid Email", message: "Please check your email", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Хорошо", style: .default)

        alertController.addAction(okAction)
        present(alertController, animated: true)
    }

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
        let attributedTitle = NSAttributedString(string: "Вы сбросили пароль", attributes: titleFont)
        let attributedMessage = NSAttributedString(string: "Проверьте вашу почту", attributes: messageFont)

        alertController.setValue(attributedTitle, forKey: "attributedTitle")
        alertController.setValue(attributedMessage, forKey: "attributedMessage")

        let okAction = UIAlertAction(title: "Спасибо", style: .default) { action in
            self.output?.onboardResetPasswordFinish(view: self)
            blurVisualEffectView.removeFromSuperview()
        }
        okAction.setValue(UIColor(red: 245/255, green: 200/255, blue: 145/255, alpha: 1), forKey: "titleTextColor")

        alertController.addAction(okAction)
        alertController.preferredAction = okAction
        present(alertController, animated: true)
    }
}
