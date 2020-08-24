//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/22/20
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
import CountryPicker
import PhoneNumberKit

extension PhoneViewAlpha: PhoneViewInput {
}

final class PhoneViewAlpha: UIViewController {
    var regionCode: String = Locale.current.regionCode ?? "RU" {
        didSet {
            self.updateRegionCode()
        }
    }
    var isConfirmEnabled: Bool = false {
        didSet {
            self.updateConfirm()
        }
    }

    init(output: PhoneViewOutput) {
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

    private let output: PhoneViewOutput
    private let textFieldsStackView = UIStackView()
    private let regionContainerView = UIView()
    private let regionFlagImageView = UIImageView()
    private let regionTextField = UITextField()
    private let numberContainerView = UIView()
    private let phoneTextField = PhoneNumberTextField()
    private let phoneContainerView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let confirmButton = UIButton()

    private let phoneNumberKit = PhoneNumberKit()
    private lazy var regionPicker: CountryPicker = {
        let picker = CountryPicker()
        picker.countryPickerDelegate = self
        picker.showPhoneNumbers = true
        return picker
    }()

    @objc
    private func confirmButtonTouchUpInside(_ sender: Any) {
        if let regionCode = self.regionTextField.text,
            let phoneNumber = self.phoneTextField.text {
            if let number = try? self.phoneNumberKit.parse(regionCode + phoneNumber) {
                let e164 = self.phoneNumberKit.format(number, toType: .e164)
                self.output.phone(view: self, didEnter: e164)
            }
        }
    }

    @objc
    private func phoneTextFieldEditingChanged(_ sender: Any) {
        self.formatPhoneNumber()
        self.dropRegionCode()
        self.trimPhoneNumber()
        self.onDidFinishPhoneInput()
    }

    private func setup() {
        self.subtitleLabel.numberOfLines = 0

        self.confirmButton.addTarget(self, action: #selector(PhoneViewAlpha.confirmButtonTouchUpInside(_:)), for: .touchUpInside)
        self.phoneTextField.addTarget(self, action: #selector(PhoneViewAlpha.phoneTextFieldEditingChanged(_:)), for: .editingChanged)

        self.regionTextField.inputView = self.regionPicker
        self.regionTextField.tintColor = .clear
        self.regionTextField.textAlignment = .right
        
        self.phoneTextField.keyboardType = .phonePad
        self.phoneTextField.autocorrectionType = .no
        self.phoneTextField.textContentType = .telephoneNumber
    }

    private func localize() {
        self.titleLabel.text = "Please enter your phone number"
        self.subtitleLabel.text = "We will send confirmation code to this number"
        self.confirmButton.setTitle("Confirm", for: .normal)
        self.phoneTextField.placeholder = "(999) 123-4567"
    }

    private func style() {
        self.view.backgroundColor = .white
        self.confirmButton.setTitleColor(.red, for: .normal)
        self.subtitleLabel.font = UIFont.systemFont(ofSize: 13)
    }
}

// MARK: - CountryPickerDelegate
extension PhoneViewAlpha: CountryPickerDelegate {
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        self.regionTextField.text = phoneCode
        self.regionFlagImageView.image = flag
        self.onDidFinishPhoneInput()
    }
}

// MARK: - Helpers
extension PhoneViewAlpha {
    private func onDidFinishPhoneInput() {
        if let regionCode = self.regionTextField.text,
            let phoneNumber = self.phoneTextField.text {
            let phone = regionCode + phoneNumber
            let isValid = (try? self.phoneNumberKit.parse(phone)) != nil
            self.isConfirmEnabled = isValid
        } else {
            self.isConfirmEnabled = false
        }
    }

    private func formatPhoneNumber() {
        if let text = self.phoneTextField.text {
            let formatter = PartialFormatter(phoneNumberKit: PhoneNumberKit(),
                                             defaultRegion: self.regionCode)
            let formatted = formatter.formatPartial(text)
            if text != formatted {
                self.phoneTextField.text = formatted
            }
        }
    }

    private func dropRegionCode() {
        if let regionCode = self.regionTextField.text,
            let startsWithRegionCode = self.phoneTextField.text?.starts(with: regionCode),
            startsWithRegionCode,
            let cropped = self.phoneTextField.text?.dropFirst(regionCode.count) {
            self.phoneTextField.text = String(cropped)
        }
    }

    private func trimPhoneNumber() {
        self.phoneTextField.text = self.phoneTextField.text?.trimmingCharacters(in: .whitespaces)
    }
}

// MARK: - Update UI
extension PhoneViewAlpha {
    private func update() {
        self.updateRegionCode()
        self.updateConfirm()
    }

    private func updateRegionCode() {
        if isViewLoaded {
            self.regionPicker.setCountry(self.regionCode)
        }
    }

    private func updateConfirm() {
        if isViewLoaded {
            self.confirmButton.isEnabled = self.isConfirmEnabled
            if self.isConfirmEnabled {
                self.confirmButton.backgroundColor = .green
            } else {
                self.confirmButton.backgroundColor = .lightGray
            }
        }
    }
}

// MARK: - Layout
extension PhoneViewAlpha {
    private func layout() {
        self.layoutStack(in: self.view)
        self.layoutTitle(in: self.textFieldsStackView)
        self.layoutSubtitle(in: self.textFieldsStackView)
        self.layoutPhoneContainer(in: self.textFieldsStackView)
        self.layoutConfirm(in: self.textFieldsStackView)
    }

    private func layoutConfirm(in stack: UIStackView) {
        let confirm = self.confirmButton
        confirm.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(confirm)
    }

    private func layoutTitle(in stack: UIStackView) {
        let title = self.titleLabel
        title.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(title)
    }

    private func layoutSubtitle(in stack: UIStackView) {
        let subtitle = self.subtitleLabel
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(subtitle)
    }

    private func layoutPhoneContainer(in stack: UIStackView) {
        let phoneContainer = self.phoneContainerView
        phoneContainer.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(phoneContainer)

        let regionContainer = self.regionContainerView
        self.layoutRegionFlag(in: regionContainer)
        self.layoutRegion(in: regionContainer)
        regionContainer.translatesAutoresizingMaskIntoConstraints = false
        phoneContainer.addSubview(regionContainer)

        let numberContainer = self.numberContainerView
        self.layoutPhone(in: numberContainer)
        numberContainer.translatesAutoresizingMaskIntoConstraints = false
        phoneContainer.addSubview(numberContainer)

        let regionFlag = self.regionFlagImageView
        let region = self.regionTextField
        NSLayoutConstraint.activate([
            region.leadingAnchor.constraint(equalTo: regionFlag.trailingAnchor, constant: 6)
        ])

        NSLayoutConstraint.activate([
            numberContainer.trailingAnchor.constraint(equalTo: phoneContainer.trailingAnchor),
            numberContainer.topAnchor.constraint(equalTo: phoneContainer.topAnchor),
            numberContainer.bottomAnchor.constraint(equalTo: phoneContainer.bottomAnchor),
            regionContainer.leadingAnchor.constraint(equalTo: phoneContainer.leadingAnchor),
            regionContainer.topAnchor.constraint(equalTo: phoneContainer.topAnchor),
            regionContainer.bottomAnchor.constraint(equalTo: phoneContainer.bottomAnchor),
            numberContainer.leadingAnchor.constraint(equalTo: regionContainer.trailingAnchor, constant: 6),
            phoneContainer.heightAnchor.constraint(equalToConstant: 44),
            regionContainer.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func layoutPhone(in container: UIView) {
        let phone = self.phoneTextField
        container.addSubview(phone)
        phone.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            phone.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            phone.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            phone.topAnchor.constraint(equalTo: container.topAnchor),
            phone.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }

    private func layoutRegion(in container: UIView) {
        let region = self.regionTextField
        container.addSubview(region)
        region.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.bottomAnchor.constraint(equalTo: region.bottomAnchor, constant: 6),
            container.trailingAnchor.constraint(equalTo: region.trailingAnchor, constant: 6),
            region.topAnchor.constraint(equalTo: container.topAnchor, constant: 6)
        ])
    }

    private func layoutRegionFlag(in container: UIView) {
        let regionFlag = self.regionFlagImageView
        container.addSubview(regionFlag)
        regionFlag.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            regionFlag.widthAnchor.constraint(equalTo: regionFlag.heightAnchor, multiplier: 5.0 / 4.0),
            regionFlag.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            regionFlag.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            container.bottomAnchor.constraint(equalTo: regionFlag.bottomAnchor, constant: 12)
        ])
    }

    private func layoutStack(in container: UIView) {
        let stack = self.textFieldsStackView
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
}

#endif
