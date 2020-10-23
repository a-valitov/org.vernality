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
    var image: Data? {
        if self.isViewLoaded {
            return self.actionImageView.image?.pngData()
        } else {
            return nil
        }
    }
    
    var activeTextField : UITextField? = nil
    @IBOutlet weak var actionImageView: UIImageView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!

    @IBOutlet weak var addActionImageView: UIButton!

    @IBAction func createActionTouchUpInside(_ sender: Any) {
        self.output?.supplierActionsDidFinish(view: self)
    }

    @IBAction func addActionImageViewTouchUpInside(_ sender: UIButton) {

        let cameraIcon = #imageLiteral(resourceName: "camera")
        let photoIcon = #imageLiteral(resourceName: "photo")

        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)

        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            self.chooseImagePicker(source: .camera)
        }

        camera.setValue(cameraIcon, forKey: "image")
        camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")

        let photo = UIAlertAction(title: "Photo", style: .default) { _ in
            self.chooseImagePicker(source: .photoLibrary)
        }

        photo.setValue(photoIcon, forKey: "image")
        photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")

        let cancel = UIAlertAction(title: "Cancel", style: .cancel)

        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)

        present(actionSheet, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        self.descriptionTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, -30, 0)
        self.linkTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)

        let textColor = UIColor(red: 0.098, green: 0.094, blue: 0.094, alpha: 1)
        let placeholderColor = textColor.withAlphaComponent(0.5)
        self.messageTextField.attributedPlaceholder = NSAttributedString(string: "Введите сообщение",
                                                                         attributes:[.foregroundColor: placeholderColor])
        self.descriptionTextField.attributedPlaceholder = NSAttributedString(string: "Введите описание акции",
                                                                             attributes:[.foregroundColor: placeholderColor])
        self.linkTextField.attributedPlaceholder = NSAttributedString(string: "Вставьте ссылку на акцию",
                                                                      attributes:[.foregroundColor: placeholderColor])

        self.messageTextField.delegate = self
        self.descriptionTextField.delegate = self
        self.linkTextField.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if actionImageView.image != nil {
            addActionImageView.setTitle("Заменить фото", for: .normal)
            addActionImageView.setTitleColor(.white, for: .normal)
            addActionImageView.imageView?.isHidden = true
        }
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

extension SupplierActionsBeta: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
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

        dismiss(animated: true)
    }
}
