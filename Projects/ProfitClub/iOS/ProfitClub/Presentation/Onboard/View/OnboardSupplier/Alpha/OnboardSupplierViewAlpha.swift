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

import UIKit

extension OnboardSupplierViewAlpha: OnboardSupplierViewInput {

}

final class OnboardSupplierViewAlpha: UIViewController {
    var output: OnboardSupplierViewOutput?

    var name: String? {
        if self.isViewLoaded {
            return self.supplierNameTextField.text
        } else {
            return nil
        }
    }
    var inn: String? {
        if self.isViewLoaded {
            return self.supplierINNTextField.text
        } else {
            return nil
        }
    }
    var contact: String? {
        if self.isViewLoaded {
            return self.supplierContactTextField.text
        } else {
            return nil
        }
    }
    var phone: String? {
        if self.isViewLoaded {
            return self.supplierPhoneNumberTextField.text
        } else {
            return nil
        }
    }

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "onboard-welcome-bg")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var supplierLabel: UILabel = {
        let label = UILabel()
        label.text = "Поставщик"
        label.textColor = #colorLiteral(red: 0.9529411765, green: 0.9176470588, blue: 0.9058823529, alpha: 1)
        label.font = UIFont(name: "PlayfairDisplay-Regular", size: 36.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var supplierSubtitle: UILabel = {
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

    private lazy var supplierNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Montserrat-Regular", size: 14.0)
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        textField.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 0.3)
        textField.layer.cornerRadius = 5
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.returnKeyType = .next
        textField.keyboardAppearance = .dark
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var supplierINNTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Montserrat-Regular", size: 14.0)
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        textField.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 0.3)
        textField.layer.cornerRadius = 5
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.returnKeyType = .next
        textField.keyboardAppearance = .dark
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var supplierContactTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Montserrat-Regular", size: 14.0)
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        textField.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 0.3)
        textField.layer.cornerRadius = 5
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.returnKeyType = .next
        textField.keyboardAppearance = .dark
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var supplierPhoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Montserrat-Regular", size: 14.0)
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        textField.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 0.3)
        textField.layer.cornerRadius = 5
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.returnKeyType = .done
        textField.keyboardAppearance = .dark
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var checkbox: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "checkmark"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "checkmark-selected"), for: .selected)
        button.addTarget(self, action: #selector(OnboardSupplierViewAlpha.checkboxTouchUpInside(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var privacyPolicyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitleColor(#colorLiteral(red: 0.9529411765, green: 0.9176470588, blue: 0.9058823529, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Monsterrat-Regular", size: 14.0)
        button.titleLabel?.numberOfLines = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var submitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.7843137255, blue: 0.568627451, alpha: 1)
        button.setTitle("Отправить данные", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 15.0)
        button.addTarget(self, action: #selector(OnboardSupplierViewAlpha.submitButtonTouchUpInside(_:)), for: .touchUpInside)
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

        privacyPolicyButton.setAttributedTitle(combination(), for: .normal)

        supplierNameTextField.delegate = self
        supplierINNTextField.delegate = self
        supplierContactTextField.delegate = self
        supplierPhoneNumberTextField.delegate = self
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
    }

    private func style() {
        let textColor = UIColor(red: 0.953, green: 0.918, blue: 0.906, alpha: 1)
        let placeholderColor = textColor.withAlphaComponent(0.5)
        self.supplierNameTextField.attributedPlaceholder = NSAttributedString(string: "Наименование",
                                                                              attributes:[.foregroundColor: placeholderColor])
        self.supplierPhoneNumberTextField.attributedPlaceholder = NSAttributedString(string: "Телефон",
                                                                                     attributes:[.foregroundColor: placeholderColor])
        self.supplierINNTextField.attributedPlaceholder = NSAttributedString(string: "ИНН",
                                                                             attributes:[.foregroundColor: placeholderColor])
        self.supplierContactTextField.attributedPlaceholder = NSAttributedString(string: "ФИО",
                                                                                 attributes:[.foregroundColor: placeholderColor])
        self.supplierNameTextField.tintColor = textColor
        self.supplierPhoneNumberTextField.tintColor = textColor
        self.supplierINNTextField.tintColor = textColor
        self.supplierContactTextField.tintColor = textColor

        self.supplierNameTextField.textColor = textColor
        self.supplierPhoneNumberTextField.textColor = textColor
        self.supplierINNTextField.textColor = textColor
        self.supplierContactTextField.textColor = textColor
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
        supplierNameTextField.resignFirstResponder()
        supplierINNTextField.resignFirstResponder()
        supplierContactTextField.resignFirstResponder()
        supplierPhoneNumberTextField.resignFirstResponder()
        if checkbox.isSelected {
            self.output?.onboardSupplier(view: self, didFinish: sender)
        }
    }

    @objc private func checkboxTouchUpInside(_ sender: UIButton) {
        sender.isSelected.toggle()
        supplierNameTextField.resignFirstResponder()
        supplierINNTextField.resignFirstResponder()
        supplierContactTextField.resignFirstResponder()
        supplierPhoneNumberTextField.resignFirstResponder()
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

}

// MARK: - Layout
extension OnboardSupplierViewAlpha {
    private func layout() {
        layoutBackgroundImageView(in: view)
        layoutSupplierLabel(in: view)
        layoutSupplierSubtitle(in: view)
        layoutStackView(in: view)
        layoutSupplierNameTextField(in: stackView)
        layoutSupplierINNTextField(in: stackView)
        layoutSupplierContactTextField(in: stackView)
        layoutSupplierPhoneNumberTextField(in: stackView)
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

    private func layoutSupplierLabel(in container: UIView) {
        let label = supplierLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 8.0),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0)
        ])
    }

    private func layoutSupplierSubtitle(in container: UIView) {
        let label = supplierSubtitle
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            label.topAnchor.constraint(equalTo: supplierLabel.bottomAnchor, constant: 8.0),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0)
        ])
    }

    private func layoutStackView(in container: UIView) {
        let stack = stackView
        container.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: supplierSubtitle.bottomAnchor, constant: 21.0),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0)
        ])
    }

    private func layoutSupplierNameTextField(in stackView: UIStackView) {
        let textField = supplierNameTextField
        stackView.addArrangedSubview(textField)
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 48.0)
        ])
    }

    private func layoutSupplierINNTextField(in stackView: UIStackView) {
        let textField = supplierINNTextField
        stackView.addArrangedSubview(textField)
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 48.0)
        ])
    }

    private func layoutSupplierContactTextField(in stackView: UIStackView) {
        let textField = supplierContactTextField
        stackView.addArrangedSubview(textField)
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 48.0)
        ])
    }

    private func layoutSupplierPhoneNumberTextField(in stackView: UIStackView) {
        let textField = supplierPhoneNumberTextField
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
            button.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: 8.0),
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
extension OnboardSupplierViewAlpha: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case supplierNameTextField:
            supplierINNTextField.becomeFirstResponder()
        case supplierINNTextField:
            supplierContactTextField.becomeFirstResponder()
        case supplierContactTextField:
            supplierPhoneNumberTextField.becomeFirstResponder()
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
