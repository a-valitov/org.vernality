//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 26.11.2020
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

final class SupplierActionsViewAlpha: UIViewController {
    var output: SupplierActionsOutput?

    var message: String? {
        if self.isViewLoaded {
            return self.messageTextField.text
        } else {
            return nil
        }
    }
    var descriptionOf: String? {
        if self.isViewLoaded {
            return self.descriptionTextView.text
        } else {
            return nil
        }
    }
    var link: String? {
        if self.isViewLoaded {
            return self.linkTextField.text
        } else {
            return nil
        }
    }
    var image: UIImage? {
        if self.isViewLoaded {
            return self.actionImageView.image
        } else {
            return nil
        }
    }

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 16
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var actionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 0.1450395976)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var messageTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.returnKeyType = .next
        textField.font = UIFont(name: "Montserrat-Regular", size: 12.0)
        textField.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        textField.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 0.1450395976)
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
        textView.autocorrectionType = .no
        textView.spellCheckingType = .no
        textView.returnKeyType = .next
        textView.font = UIFont(name: "Montserrat-Regular", size: 12.0)
        textView.textColor = #colorLiteral(red: 0.1298349798, green: 0.1296681762, blue: 0.1242521927, alpha: 0.5)
        textView.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 0.1450395976)
        textView.layer.cornerRadius = 5
        textView.text = "Введите описание акции"
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private lazy var linkTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.returnKeyType = .next
        textField.font = UIFont(name: "Montserrat-Regular", size: 12.0)
        textField.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        textField.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 0.1450395976)
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var addPhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        button.backgroundColor = .clear
        button.setTitle("Добавить фото", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 12.0)
        button.alpha = 0.7
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 25.0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 60.0, left: 0, bottom: 0, right: 25.0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 96.0, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(SupplierActionsViewAlpha.addPhotoTouchUpInside(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var startDateTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.font = UIFont(name: "Montserrat-Regular", size: 12.0)
        textField.borderStyle = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.returnKeyType = .next
        textField.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        textField.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 0.1450395976)
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var endDateTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.font = UIFont(name: "Montserrat-Regular", size: 12.0)
        textField.borderStyle = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.returnKeyType = .next
        textField.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        textField.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 0.1450395976)
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var createActionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15.0)
        button.setTitle("Создать акцию", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.9450980392, green: 0.9058823529, blue: 0.8941176471, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(SupplierActionsViewAlpha.createActionTouchUpInside(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var startDate: Date?
    var endDate: Date?

    var activeTextField: UITextField? = nil
    let datePicker = UIDatePicker()

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

        self.descriptionTextView.delegate = self
        self.messageTextField.delegate = self
        self.linkTextField.delegate = self
        self.startDateTextField.delegate = self
        self.endDateTextField.delegate = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    private func setup() {
        view.backgroundColor = .white

        if #available(iOS 13.4, *) {
            self.datePicker.preferredDatePickerStyle = .wheels
        }

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "barItem"), style: .plain, target: self, action: #selector(menuBarButtonItemAction))

        let textColor = UIColor(red: 0.098, green: 0.094, blue: 0.094, alpha: 1)
        let placeholderColor = textColor.withAlphaComponent(0.5)
        self.messageTextField.attributedPlaceholder = NSAttributedString(string: "Введите сообщение",
                                                                         attributes:[.foregroundColor: placeholderColor])
        self.linkTextField.attributedPlaceholder = NSAttributedString(string: "Вставьте ссылку на акцию",
                                                                      attributes:[.foregroundColor: placeholderColor])
        self.startDateTextField.attributedPlaceholder = NSAttributedString(string: "Старт акции",
                                                                                 attributes:[.foregroundColor: placeholderColor])
        self.endDateTextField.attributedPlaceholder = NSAttributedString(string: "Конец акции",
                                                                               attributes:[.foregroundColor: placeholderColor])

        addPadding(to: messageTextField)
        addPadding(to: linkTextField)
    }

    private func addPadding(to textField: UITextField) {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftView = leftView
        textField.leftViewMode = .always
    }

    @objc private func createActionTouchUpInside(_ sender: Any) {
        self.output?.supplierActionsDidFinish(view: self)
    }

    @objc private func addPhotoTouchUpInside(_ sender: Any) {
        let cameraIcon = #imageLiteral(resourceName: "camera")
        let photoIcon = #imageLiteral(resourceName: "photo")

        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        actionSheet.view.tintColor = .black

        let camera = UIAlertAction(title: "Камера", style: .default) { _ in
            self.chooseImagePicker(source: .camera)
        }

        camera.setValue(cameraIcon, forKey: "image")
        camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")

        let photo = UIAlertAction(title: "Фото", style: .default) { _ in
            self.chooseImagePicker(source: .photoLibrary)
        }

        photo.setValue(photoIcon, forKey: "image")
        photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")

        let cancel = UIAlertAction(title: "Отменить", style: .cancel)
        cancel.setValue(UIColor.red, forKey: "titleTextColor")

        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)

        present(actionSheet, animated: true)
    }

    @objc private func menuBarButtonItemAction(_ sender: Any) {
        self.output?.supplierActions(view: self, tappenOn: sender)
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
extension SupplierActionsViewAlpha {
    private func layout() {
        layoutStackView(in: self.view)
        layoutActionImageView(in: self.stackView)
        layoutMessageTextField(in: self.stackView)
        layoutDescriptionTextView(in: self.stackView)
        layoutLinkTextField(in: self.stackView)
        layoutAddPhotoButton(in: self.view)
        layoutStartDateTextField(in: self.view)
        layoutEndDateTextField(in: self.view)
        layoutCreateActionButton(in: self.view)
    }

    private func layoutStackView(in container: UIView) {
        let stack = stackView
        container.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0)
        ])
    }

    private func layoutActionImageView(in stack: UIStackView) {
        let imageView = actionImageView
        stack.addArrangedSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 178.0)
        ])
    }

    private func layoutMessageTextField(in stack: UIStackView) {
        let textField = messageTextField
        stack.addArrangedSubview(textField)
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 48.0)
        ])
    }

    private func layoutDescriptionTextView(in stack: UIStackView) {
        let textView = descriptionTextView
        stack.addArrangedSubview(textView)
        NSLayoutConstraint.activate([
            textView.heightAnchor.constraint(equalToConstant: 109.0)
        ])
    }

    private func layoutLinkTextField(in stack: UIStackView) {
        let textField = linkTextField
        stack.addArrangedSubview(textField)
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 48.0)
        ])
    }

    private func layoutAddPhotoButton(in container: UIView) {
        let button = addPhotoButton
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.actionImageView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.actionImageView.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 162.0),
            button.widthAnchor.constraint(equalToConstant: 359.0)
        ])
    }

    private func layoutStartDateTextField(in container: UIView) {
        let textField = startDateTextField
        container.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            textField.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 16.0),
            textField.heightAnchor.constraint(equalToConstant: 28.0),
            textField.widthAnchor.constraint(equalToConstant: 100.0)
        ])
    }

    private func layoutEndDateTextField(in container: UIView) {
        let textField = endDateTextField
        container.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            textField.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 16.0),
            textField.heightAnchor.constraint(equalToConstant: 28.0),
            textField.widthAnchor.constraint(equalToConstant: 100.0)
        ])
    }

    private func layoutCreateActionButton(in container: UIView) {
        let button = createActionButton
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
extension SupplierActionsViewAlpha: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case messageTextField:
            descriptionTextView.becomeFirstResponder()
        case linkTextField:
            startDateTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        if activeTextField == startDateTextField {
            setDatePicker(forField: startDateTextField)
        }
        if activeTextField == endDateTextField {
            setDatePicker(forField: endDateTextField)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }

    func setDatePicker(forField textField: UITextField) {
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.backgroundColor = .white
        let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(doneDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelDatePicker))

        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)

        textField.inputAccessoryView = toolbar
        textField.inputView = self.datePicker
    }

    @objc func doneDatePicker() {
        if let activeTextField = activeTextField {
            let formatter = DateFormatter()
            formatter.locale = Locale.autoupdatingCurrent
            formatter.dateFormat = "dd.MM.yyyy"
            activeTextField.text = formatter.string(from: datePicker.date)
            switch activeTextField {
            case self.startDateTextField:
                self.startDate = Calendar.current.startOfDay(for: self.datePicker.date)
            case self.endDateTextField:
                self.endDate = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: self.datePicker.date)
            default:
                break
            }
        }
        self.view.endEditing(true)
    }

    @objc func cancelDatePicker() {
        self.view.endEditing(true)
    }
}

// MARK: - UITextViewDelegate
extension SupplierActionsViewAlpha: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Введите описание акции" {
            textView.text = ""
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Введите описание акции"
            textView.textColor = #colorLiteral(red: 0.1298349798, green: 0.1296681762, blue: 0.1242521927, alpha: 0.5)
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

// MARK: - UIImagePickerControllerDelegate
extension SupplierActionsViewAlpha: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            imagePicker.modalPresentationStyle = .fullScreen
            present(imagePicker, animated: true)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        actionImageView.image = info[.editedImage] as? UIImage
        actionImageView.contentMode = .scaleAspectFill
        actionImageView.clipsToBounds = true
        addPhotoButton.setImage(nil, for: .normal)
        addPhotoButton.setTitle("Заменить фото", for: .normal)
        addPhotoButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)

        dismiss(animated: true)
    }
}

extension SupplierActionsViewAlpha: SupplierActionsInput {
}
