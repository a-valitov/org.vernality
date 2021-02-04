//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 21.10.2020
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

extension SupplierActionsBeta: SupplierActionsInput {
}

final class SupplierActionsBeta: UIViewController {
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
            return self.descriptionTextField.text
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

    private var cameraIcon: UIImage?
    private var photoIcon: UIImage?

    var startDate: Date?
    var endDate: Date?
    
    var activeTextField: UITextField? = nil
    let datePicker = UIDatePicker()

    @IBOutlet weak var actionImageView: UIImageView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var actionStartDateTextField: UITextField!
    @IBOutlet weak var actionEndDataTextField: UITextField!
    
    @IBOutlet weak var addActionImageView: UIButton!

    @IBAction func createActionTouchUpInside(_ sender: Any) {
        self.output?.supplierActionsDidFinish(view: self)
    }

    @IBAction func addActionImageViewTouchUpInside(_ sender: UIButton) {

        #if SWIFT_PACKAGE
        cameraIcon = UIImage(named: "camera", in: Bundle.module, compatibleWith: nil)
        #else
        cameraIcon = UIImage(named: "camera", in: Bundle(for: Self.self), compatibleWith: nil)
        #endif

        #if SWIFT_PACKAGE
        photoIcon = UIImage(named: "photo", in: Bundle.module, compatibleWith: nil)
        #else
        photoIcon = UIImage(named: "photo", in: Bundle(for: Self.self), compatibleWith: nil)
        #endif

        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)

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

        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)

        present(actionSheet, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPadding(to: messageTextField)
        addPadding(to: descriptionTextField)
        addPadding(to: linkTextField)
        self.descriptionTextField.layer.sublayerTransform = CATransform3DMakeTranslation(0, 15, 0)

        let textColor = UIColor(red: 0.098, green: 0.094, blue: 0.094, alpha: 1)
        let placeholderColor = textColor.withAlphaComponent(0.5)
        self.messageTextField.attributedPlaceholder = NSAttributedString(string: "Введите название акции",
                                                                         attributes:[.foregroundColor: placeholderColor])
        self.descriptionTextField.attributedPlaceholder = NSAttributedString(string: "Введите описание акции",
                                                                             attributes:[.foregroundColor: placeholderColor])
        self.linkTextField.attributedPlaceholder = NSAttributedString(string: "Вставьте ссылку на акцию",
                                                                      attributes:[.foregroundColor: placeholderColor])
        self.actionStartDateTextField.attributedPlaceholder = NSAttributedString(string: "Старт акции",
                                                                                 attributes:[.foregroundColor: placeholderColor])
        self.actionEndDataTextField.attributedPlaceholder = NSAttributedString(string: "Конец акции",
                                                                               attributes:[.foregroundColor: placeholderColor])

        self.messageTextField.delegate = self
        self.descriptionTextField.delegate = self
        self.linkTextField.delegate = self
        self.actionStartDateTextField.delegate = self
        self.actionEndDataTextField.delegate = self
        if #available(iOS 13.4, *) {
            self.datePicker.preferredDatePickerStyle = .wheels
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "barItem"), style: .plain, target: self, action: #selector(menuBarButtonItemAction))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if actionImageView.image != nil {
            addActionImageView.setTitle("Заменить фото", for: .normal)
            addActionImageView.setTitleColor(.white, for: .normal)
            addActionImageView.imageView?.isHidden = true
        }
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

    func addPadding(to textField: UITextField) {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftView = leftView
        textField.leftViewMode = .always
    }
}

extension SupplierActionsBeta: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        if activeTextField == actionStartDateTextField {
            setDatePicker(forField: actionStartDateTextField)
        }
        if activeTextField == actionEndDataTextField {
            setDatePicker(forField: actionEndDataTextField)
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
            case self.actionStartDateTextField:
                self.startDate = Calendar.current.startOfDay(for: self.datePicker.date)
            case self.actionEndDataTextField:
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

extension SupplierActionsBeta: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
        addActionImageView.setImage(nil, for: .normal)
        addActionImageView.setTitle("Заменить фото", for: .normal)
        addActionImageView.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)

        dismiss(animated: true)
    }
}
