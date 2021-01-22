//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 24.11.2020
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

final class OnboardMemberViewAlpha: UIViewController {
    var output: OnboardMemberViewOutput?

    var firstName: String? {
        get {
            if isViewLoaded {
                return memberNameTextField.text
            } else {
                return nil
            }
        }
    }
    var lastName: String? {
        get {
            if isViewLoaded {
                return memberSurnameTextField.text
            } else {
                return nil
            }
        }
    }
    var image: UIImage? {
        if self.isViewLoaded {
            #if SWIFT_PACKAGE
            return UIImage(named: "profileImage", in: Bundle.module, compatibleWith: nil)
            #else
             return UIImage(named: "profileImage", in: Bundle(for: Self.self), compatibleWith: nil)
            #endif
        } else {
            return nil
        }
    }

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var memberLabel: UILabel = {
        let label = UILabel()
        label.text = "Участник"
        label.textColor = #colorLiteral(red: 0.9529411765, green: 0.9176470588, blue: 0.9058823529, alpha: 1)
        label.font = UIFont(name: "PlayfairDisplay-Regular", size: 36.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var memberSubtitle: UILabel = {
        let label = UILabel()
        label.text = "Укажите дополнительные данные для вступления в клуб"
        label.textColor = #colorLiteral(red: 0.9529411765, green: 0.9176470588, blue: 0.9058823529, alpha: 1)
        label.font = UIFont(name: "Montserrat-Regular", size: 16.0)
        label.numberOfLines = 0
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

    private lazy var memberNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Montserrat-Regular", size: 14.0)
        textField.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 0.3)
        textField.layer.cornerRadius = 5
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.returnKeyType = .next
        textField.keyboardAppearance = .dark
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textContentType = .name
        return textField
    }()

    private lazy var memberSurnameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Montserrat-Regular", size: 14.0)
        textField.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 0.3)
        textField.layer.cornerRadius = 5
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.returnKeyType = .done
        textField.keyboardAppearance = .dark
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textContentType = .familyName
        return textField
    }()

    private lazy var checkbox: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(OnboardMemberViewAlpha.checkboxTouchUpInside(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var privacyPolicyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9176470588, blue: 0.9058823529, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Monsterrat-Regular", size: 14.0)
        button.titleLabel?.numberOfLines = 0
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var submitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.7843137255, blue: 0.568627451, alpha: 1)
        button.setTitle("Отправить данные", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 15.0)
        button.addTarget(self, action: #selector(OnboardMemberViewAlpha.submitButtonTouchUpInside(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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

        privacyPolicyButton.setAttributedTitle(combination(), for: .normal)

        memberNameTextField.delegate = self
        memberSurnameTextField.delegate = self

        #if SWIFT_PACKAGE
        backgroundImageView.image = UIImage(named: "onboard-welcome-bg", in: Bundle.module, compatibleWith: nil)
        #else
        backgroundImageView.image = UIImage(named: "onboard-welcome-bg", in: Bundle(for: Self.self), compatibleWith: nil)
        #endif
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    private func setup() {
        view.backgroundColor = .clear

        var blurEffect = UIBlurEffect()
        if #available(iOS 13.0, *) {
            blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        } else {
            blurEffect = UIBlurEffect(style: .dark)
        }
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = view.bounds
        self.backgroundImageView.addSubview(blurVisualEffectView)

        addPadding(to: memberNameTextField)
        addPadding(to: memberSurnameTextField)

        #if SWIFT_PACKAGE
        checkbox.setImage(UIImage(named: "checkmark", in: Bundle.module, compatibleWith: nil), for: .normal)
        #else
        checkbox.setImage(UIImage(named: "checkmark", in: Bundle(for: Self.self), compatibleWith: nil), for: .normal)
        #endif

        #if SWIFT_PACKAGE
        checkbox.setImage(UIImage(named: "checkmark-selected", in: Bundle.module, compatibleWith: nil), for: .selected)
        #else
        checkbox.setImage(UIImage(named: "checkmark-selected", in: Bundle(for: Self.self), compatibleWith: nil), for: .selected)
        #endif
    }

    private func addPadding(to textField: UITextField) {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftView = leftView
        textField.leftViewMode = .always
    }

    private func style() {
        let textColor = UIColor(red: 0.953, green: 0.918, blue: 0.906, alpha: 1)
        let placeholderColor = textColor.withAlphaComponent(0.5)
        memberNameTextField.attributedPlaceholder = NSAttributedString(string: "Имя", attributes: [.foregroundColor: placeholderColor])
        memberSurnameTextField.attributedPlaceholder = NSAttributedString(string: "Фамилия", attributes: [.foregroundColor: placeholderColor])

        memberNameTextField.textColor = textColor
        memberSurnameTextField.textColor = textColor

        memberNameTextField.tintColor = textColor
        memberSurnameTextField.tintColor = textColor
    }

    private func combination() -> NSMutableAttributedString {
        let attributesForFirstTitle: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue,
            NSAttributedString.Key.foregroundColor: UIColor(red: 245/255, green: 200/255, blue: 145/255, alpha: 1)
        ]
        let attributesForSecondTitle: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 243/255, green: 234/255, blue: 231/255, alpha: 1)
        ]
        let firstTitle = NSAttributedString(string: "политики конфиденциальности", attributes: attributesForFirstTitle)
        let secondTitle = NSAttributedString(string: "Я согласен с условиями ", attributes: attributesForSecondTitle)

        let combination = NSMutableAttributedString()
        combination.append(secondTitle)
        combination.append(firstTitle)

        return combination
    }

    @objc private func submitButtonTouchUpInside(_ sender: Any) {
        memberNameTextField.resignFirstResponder()
        memberSurnameTextField.resignFirstResponder()
        if checkbox.isSelected {
            self.output?.onboardMemberDidFinish(view: self)
        }
    }

    @objc private func checkboxTouchUpInside(_ sender: UIButton) {
        sender.isSelected.toggle()
        memberSurnameTextField.resignFirstResponder()
        memberNameTextField.resignFirstResponder()
    }
}

// MARK: - Layout
extension OnboardMemberViewAlpha {
    private func layout() {
        layoutBackgroundImageView(in: view)
        layoutMemberLabel(in: view)
        layoutMemberSubtitle(in: view)
        layoutStackView(in: view)
        layoutMemberNameTextField(in: stackView)
        layoutMemberSurnameTextField(in: stackView)
        layoutCheckbox(in: view)
        layoutPrivacyButton(in: view)
        layoutSubmitButton(in: view)
    }

    private func layoutBackgroundImageView(in container: UIView) {
        let image = backgroundImageView
        container.addSubview(image)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 0),
            image.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            image.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            image.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0)
        ])
    }

    private func layoutMemberLabel(in container: UIView) {
        let label = memberLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0)
        ])
    }

    private func layoutMemberSubtitle(in container: UIView) {
        let label = memberSubtitle
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            label.topAnchor.constraint(equalTo: memberLabel.bottomAnchor, constant: 8.0),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0)
        ])
    }

    private func layoutStackView(in container: UIView) {
        let stack = stackView
        container.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: memberSubtitle.bottomAnchor, constant: 21.0),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0)
        ])
    }

    private func layoutMemberNameTextField(in stackView: UIStackView) {
        let textField = memberNameTextField
        stackView.addArrangedSubview(textField)
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 52.0)
        ])
    }

    private func layoutMemberSurnameTextField(in stackView: UIStackView) {
        let textField = memberSurnameTextField
        stackView.addArrangedSubview(textField)
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 52.0)
        ])
    }

    private func layoutCheckbox(in container: UIView) {
        let button = checkbox
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 35.0),
            button.widthAnchor.constraint(equalToConstant: 24.0)
        ])
    }

    private func layoutPrivacyButton(in container: UIView) {
        let button = privacyPolicyButton
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: 15.0),
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            button.centerYAnchor.constraint(equalTo: checkbox.centerYAnchor)
        ])
    }

    private func layoutSubmitButton(in container: UIView) {
        let button = submitButton
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            button.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor, constant: -20.0),
            button.heightAnchor.constraint(equalToConstant: 52.0)
        ])
    }
}

// MARK: - UITextFieldDelegate
extension OnboardMemberViewAlpha: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case memberNameTextField:
            memberSurnameTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
}

extension OnboardMemberViewAlpha: OnboardMemberViewInput {

}

