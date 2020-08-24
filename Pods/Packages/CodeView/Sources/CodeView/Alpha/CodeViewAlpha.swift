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

extension CodeViewAlpha: CodeViewInput {
}

final class CodeViewAlpha: UIViewController {
    init(length: Int, output: CodeViewOutput) {
        self.length = length
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
        self.setupTextFields()
        self.setupTitleLabel()
        self.setupSubtitleLabel()
    }

    private func setupTitleLabel() {
        self.titleLabel.font = UIFont.systemFont(ofSize: 17)
    }

    private func setupSubtitleLabel() {
        self.subtitleLabel.numberOfLines = 0
        self.subtitleLabel.font = UIFont.systemFont(ofSize: 13)
    }

    private func setupTextFields() {
        for _ in 0..<self.length {
            let textField = DigitTextField()
            self.setupTextField(textField)
            self.textFields.append(textField)
        }
    }

    private func setupTextField(_ textField: DigitTextField) {
        textField.delegate = self
        textField.digitDelegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.adjustsFontSizeToFitWidth = false
        textField.keyboardType = .numberPad
        textField.autocorrectionType = .yes
        textField.tintColor = .clear
        if #available(iOS 12.0, *) {
            textField.textContentType = .oneTimeCode
        }
        textField.addTarget(self, action: #selector(CodeViewAlpha.digitTextFieldEditingChanged(_:)), for: .editingChanged)
    }

    @objc
    private func digitTextFieldEditingChanged(_ textField: DigitTextField) {
        let didEnterDigit = textField.text?.isEmpty == false
        if didEnterDigit {
            let nextIndex = (self.textFields.firstIndex(of: textField) ?? 0) + 1
            if nextIndex < self.textFields.count {
                self.textFields[nextIndex].becomeFirstResponder()

            }
            self.notifyOutputIfNeededOnDidInputDigit()
        }
    }

    private func notifyOutputIfNeededOnDidInputDigit() {
        var result = ""
        for textField in self.textFields {
            if let text = textField.text, text.isEmpty == false {
                result += text
            } else {
                return
            }
        }
        self.output.code(view: self, didInput: result)
    }

    private func layout() {
        self.layoutStack(in: self.view)
        self.layoutTitle(in: self.stackView)
        self.layoutSubtitle(in: self.stackView)
        self.layoutTextFieldsStack(in: self.stackView)
        self.layoutTextFields(in: self.textFieldsStackView)
    }

    private func layoutSubtitle(in stackView: UIStackView) {
        let subtitle = self.subtitleLabel
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(subtitle)
    }

    private func layoutTitle(in stackView: UIStackView) {
        let title = self.titleLabel
        title.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(title)
    }

    private func layoutTextFieldsStack(in stackView: UIStackView) {
        let textFieldsStack = self.textFieldsStackView
        textFieldsStack.contentMode = .center
        textFieldsStack.distribution = .fillEqually
        textFieldsStack.axis = .horizontal
        textFieldsStack.spacing = 5
        textFieldsStack.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(textFieldsStack)
    }

    private func layoutTextFields(in stack: UIStackView) {
        self.textFields.forEach { textField in
            textField.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview(textField)
        }
    }

    private func layoutStack(in container: UIView) {
        let stack = self.stackView
        stack.contentMode = .center
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 5
        container.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            container.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 20),
            container.safeAreaLayoutGuide.bottomAnchor.constraint(greaterThanOrEqualTo: stack.bottomAnchor, constant: 60),
            stack.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 40)
        ])
    }

    private func localize() {
        self.titleLabel.text = "Enter the code from SMS"
        self.subtitleLabel.text = "We sent an SMS with the code to your phone "
    }

    private func style() {
        self.view.backgroundColor = .white
        self.textFieldsStackView.backgroundColor = .clear
        self.textFields.forEach({ self.styleTextField($0) })
    }

    private func styleTextField(_ textField: DigitTextField) {
        textField.borderStyle = .line
    }

    private func update() {
    }

    private let length: Int
    private let output: CodeViewOutput
    private let stackView = UIStackView()
    private let textFieldsStackView = UIStackView()
    private var textFields = [DigitTextField]()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
}

extension CodeViewAlpha: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string)) {
            textField.text = nil
            return string.count > 0
        } else {
            return false
        }
    }
}

extension CodeViewAlpha: DigitTextFieldDelegate {
    fileprivate func digitTextFieldDidDeleteBackward(_ textField: DigitTextField) {
        if let index = self.textFields.firstIndex(of: textField), index > 0 {
            if self.textFields[index].text?.isEmpty == false {
                self.textFields[index].text = nil
                self.textFields[index].becomeFirstResponder()
            } else {
                self.textFields[index - 1].text = nil
                self.textFields[index - 1].becomeFirstResponder()
            }
        }
    }
}

@objc
fileprivate protocol DigitTextFieldDelegate: class {
    func digitTextFieldDidDeleteBackward(_ textField: DigitTextField)
}

fileprivate final class DigitTextField: UITextField {
    weak var digitDelegate: DigitTextFieldDelegate?

    override func deleteBackward() {
        super.deleteBackward()
        self.digitDelegate?.digitTextFieldDidDeleteBackward(self)
    }

    @discardableResult
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        layer.borderColor = UIColor.red.cgColor
        return true
    }

    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        layer.borderColor = UIColor.black.cgColor
        return true
    }
}

#endif
