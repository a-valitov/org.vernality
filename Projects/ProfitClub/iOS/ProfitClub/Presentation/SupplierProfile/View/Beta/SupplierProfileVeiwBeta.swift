//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 17.11.2020
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

final class SupplierProfileViewBeta: UIViewController {
    var output: SupplierProfileViewOutput?

    var supplierName: String? { didSet { self.updateUIName() } }
    var supplierINN: String? { didSet { self.updateUIINN() } }
    var supplierContactName: String? { didSet { self.updateUIContactName() } }
    var supplierPhoneNumber: String? { didSet { self.updateUIPhoneNumber() } }

    @IBOutlet weak var supplierImageView: UIImageView!
    @IBOutlet weak var supplierNameLabel: UILabel!
    @IBOutlet weak var suplierINNLabel: UILabel!
    @IBOutlet weak var supplierContactNameLabel: UILabel!
    @IBOutlet weak var supplierEmailLabel: UILabel!
    @IBOutlet weak var supplierPhoneNumberLabel: UILabel!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var deleteAccountButton: UIButton!

    override func viewDidLoad() {
        deleteAccountButton.titleLabel?.attributedText = NSAttributedString(string: "Удалить аккаунт", attributes: [.underlineStyle: NSUnderlineStyle.thick.rawValue])

        self.updateUI()

        navigationItem.title = "Профиль"
    }

    override func viewWillLayoutSubviews() {
        addPhotoButton.layer.cornerRadius = addPhotoButton.frame.height / 2
        supplierImageView.layer.cornerRadius = supplierImageView.frame.height / 2
    }

    @IBAction func addPhotoButtonTouchUpInside() {
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

        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)

        present(actionSheet, animated: true)
    }

    @IBAction func deleteAccountTouchUpInside(_ sender: Any) {
    }
}

extension SupplierProfileViewBeta: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        supplierImageView.image = info[.editedImage] as? UIImage
        supplierImageView.contentMode = .scaleAspectFill
        supplierImageView.clipsToBounds = true

        dismiss(animated: true)
    }
}

extension SupplierProfileViewBeta {

}

extension SupplierProfileViewBeta: SupplierProfileViewInput {
    private func updateUI() {
        updateUIName()
        updateUIINN()
        updateUIContactName()
        updateUIPhoneNumber()
    }

    private func updateUIName() {
        if self.isViewLoaded {
            self.supplierNameLabel.text = self.supplierName
        }
    }
    private func updateUIINN() {
        if self.isViewLoaded {
            self.suplierINNLabel.text = self.supplierINN
        }
    }
    private func updateUIContactName() {
        if self.isViewLoaded {
            self.supplierContactNameLabel.text = self.supplierContactName
        }
    }
    private func updateUIPhoneNumber() {
        if self.isViewLoaded {
            self.supplierPhoneNumberLabel.text = self.supplierPhoneNumber
        }
    }
}
