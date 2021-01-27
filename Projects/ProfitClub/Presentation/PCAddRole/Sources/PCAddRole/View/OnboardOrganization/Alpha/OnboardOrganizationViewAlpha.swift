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

final class OnboardOrganizationViewAlpha: UIViewController {
    var output: OnboardOrganizationViewOutput?
    var name: String? {
        if self.isViewLoaded {
            return self.organizationNameTextField.text
        } else {
            return nil
        }
    }
    var inn: String? {
        if self.isViewLoaded {
            return self.organizationINNTextField.text
        } else {
            return nil
        }
    }
    var contact: String? {
        if self.isViewLoaded {
            return self.organizationContactTextField.text
        } else {
            return nil
        }
    }
    var phone: String? {
        if self.isViewLoaded {
            return self.organizationPhoneNumberTextField.text
        } else {
            return nil
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

    private lazy var organizationLabel: UILabel = {
        let label = UILabel()
        label.text = "Организация"
        label.textColor = #colorLiteral(red: 0.9529411765, green: 0.9176470588, blue: 0.9058823529, alpha: 1)
        label.font = UIFont(name: "PlayfairDisplay-Regular", size: 36.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var organizationSubtitle: UILabel = {
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

    private lazy var organizationNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Montserrat-Regular", size: 14.0)
        textField.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 0.3)
        textField.layer.cornerRadius = 5
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.returnKeyType = .next
        textField.keyboardAppearance = .dark
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var organizationINNTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Montserrat-Regular", size: 14.0)
        textField.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 0.3)
        textField.layer.cornerRadius = 5
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.returnKeyType = .next
        textField.keyboardType = .numberPad
        textField.keyboardAppearance = .dark
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var organizationContactTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Montserrat-Regular", size: 14.0)
        textField.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 0.3)
        textField.layer.cornerRadius = 5
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.returnKeyType = .next
        textField.keyboardAppearance = .dark
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var organizationPhoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Montserrat-Regular", size: 14.0)
        textField.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 0.3)
        textField.layer.cornerRadius = 5
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.returnKeyType = .done
        textField.keyboardType = .phonePad
        textField.keyboardAppearance = .dark
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var checkbox: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(OnboardOrganizationViewAlpha.checkboxTouchUpInside(_:)), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(OnboardOrganizationViewAlpha.submitButtonTouchUpInside(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var activeTextField : UITextField? = nil

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
        addDoneButtonOnKeyboard()
        addNextButtonOnKeyboard()

        privacyPolicyButton.setAttributedTitle(combination(), for: .normal)

        organizationNameTextField.delegate = self
        organizationINNTextField.delegate = self
        organizationContactTextField.delegate = self
        organizationPhoneNumberTextField.delegate = self

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

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        addPadding(to: organizationNameTextField)
        addPadding(to: organizationINNTextField)
        addPadding(to: organizationContactTextField)
        addPadding(to: organizationPhoneNumberTextField)

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
        self.organizationNameTextField.attributedPlaceholder = NSAttributedString(string: "Наименование",
                                                                              attributes:[.foregroundColor: placeholderColor])
        self.organizationPhoneNumberTextField.attributedPlaceholder = NSAttributedString(string: "Телефон",
                                                                                     attributes:[.foregroundColor: placeholderColor])
        self.organizationINNTextField.attributedPlaceholder = NSAttributedString(string: "ИНН",
                                                                             attributes:[.foregroundColor: placeholderColor])
        self.organizationContactTextField.attributedPlaceholder = NSAttributedString(string: "ФИО",
                                                                                 attributes:[.foregroundColor: placeholderColor])

        self.organizationNameTextField.autocapitalizationType = .words
        self.organizationContactTextField.autocapitalizationType = .words

        self.organizationNameTextField.tintColor = textColor
        self.organizationPhoneNumberTextField.tintColor = textColor
        self.organizationINNTextField.tintColor = textColor
        self.organizationContactTextField.tintColor = textColor

        self.organizationNameTextField.textColor = textColor
        self.organizationPhoneNumberTextField.textColor = textColor
        self.organizationINNTextField.textColor = textColor
        self.organizationContactTextField.textColor = textColor
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

    private func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(self.doneButtonAction))
        done.tintColor = .white

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        organizationPhoneNumberTextField.inputAccessoryView = doneToolbar
    }

    private func addNextButtonOnKeyboard(){
        let nextToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        nextToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let next: UIBarButtonItem = UIBarButtonItem(title: "Далее", style: .done, target: self, action: #selector(self.nextButtonAction))
        next.tintColor = .white

        let items = [flexSpace, next]
        nextToolbar.items = items
        nextToolbar.sizeToFit()

        organizationINNTextField.inputAccessoryView = nextToolbar
    }

    @objc private func submitButtonTouchUpInside(_ sender: Any) {
        organizationNameTextField.resignFirstResponder()
        organizationINNTextField.resignFirstResponder()
        organizationContactTextField.resignFirstResponder()
        organizationPhoneNumberTextField.resignFirstResponder()
        if checkbox.isSelected {
            self.output?.onboardOrganizationDidFinish(view: self)
        }
    }

    @objc private func checkboxTouchUpInside(_ sender: UIButton) {
        sender.isSelected.toggle()
        organizationNameTextField.resignFirstResponder()
        organizationINNTextField.resignFirstResponder()
        organizationContactTextField.resignFirstResponder()
        organizationPhoneNumberTextField.resignFirstResponder()
    }

    @objc func keyboardWillShow(notification: NSNotification) {

        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

        var shouldMoveViewUp = false

        if let activeTextField = activeTextField {
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
            let topOfKeyboard = self.view.frame.height - keyboardSize.height

            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }

        if (shouldMoveViewUp) {
            self.view.frame.origin.y = 0 - keyboardSize.height
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }

    @objc func doneButtonAction() {
        organizationPhoneNumberTextField.resignFirstResponder()
    }

    @objc func nextButtonAction() {
        organizationContactTextField.becomeFirstResponder()
    }
}

// MARK: - Layout
extension OnboardOrganizationViewAlpha {
    private func layout() {
        layoutBackgroundImageView(in: view)
        layoutOrganizationLabel(in: view)
        layoutOrganizationSubtitle(in: view)
        layoutStackView(in: view)
        layoutOrganizationNameTextField(in: stackView)
        layoutOrganizationINNTextField(in: stackView)
        layoutOrganizationContactTextField(in: stackView)
        layoutOrganizationPhoneNumberTextField(in: stackView)
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

    private func layoutOrganizationLabel(in container: UIView) {
        let label = organizationLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 8.0),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0)
        ])
    }

    private func layoutOrganizationSubtitle(in container: UIView) {
        let label = organizationSubtitle
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            label.topAnchor.constraint(equalTo: organizationLabel.bottomAnchor, constant: 8.0),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0)
        ])
    }

    private func layoutStackView(in container: UIView) {
        let stack = stackView
        container.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: organizationSubtitle.bottomAnchor, constant: 21.0),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0)
        ])
    }

    private func layoutOrganizationNameTextField(in stackView: UIStackView) {
        let textField = organizationNameTextField
        stackView.addArrangedSubview(textField)
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 48.0)
        ])
    }

    private func layoutOrganizationINNTextField(in stackView: UIStackView) {
        let textField = organizationINNTextField
        stackView.addArrangedSubview(textField)
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 48.0)
        ])
    }

    private func layoutOrganizationContactTextField(in stackView: UIStackView) {
        let textField = organizationContactTextField
        stackView.addArrangedSubview(textField)
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 48.0)
        ])
    }

    private func layoutOrganizationPhoneNumberTextField(in stackView: UIStackView) {
        let textField = organizationPhoneNumberTextField
        stackView.addArrangedSubview(textField)
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 48.0)
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
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -35.0),
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
extension OnboardOrganizationViewAlpha: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case organizationNameTextField:
            organizationINNTextField.becomeFirstResponder()
        case organizationINNTextField:
            organizationContactTextField.becomeFirstResponder()
        case organizationContactTextField:
            organizationPhoneNumberTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
}

extension OnboardOrganizationViewAlpha: OnboardOrganizationViewInput {
    
}
