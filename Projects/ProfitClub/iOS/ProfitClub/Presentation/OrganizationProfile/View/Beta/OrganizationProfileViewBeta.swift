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

final class OrganizationProfileViewBeta: UIViewController {
    var output: OrganizationProfileViewOutput?

    var organizationName: String? { didSet { self.updateUIName() } }
    var organizationINN: String? { didSet { self.updateUIINN() } }
    var organizationContactName: String? { didSet { self.updateUIContactName() } }
    var organizationPhoneNumber: String? { didSet { self.updateUIPhoneNumber() } }
    var email: String? { didSet { self.updateUIEmail() } }

    @IBOutlet weak var organizationImageView: UIImageView!
    @IBOutlet weak var organizationNameLabel: UILabel!
    @IBOutlet weak var organizationINNLabel: UILabel!
    @IBOutlet weak var organizationContactNameLabel: UILabel!
    @IBOutlet weak var organizationEmailLabel: UILabel!
    @IBOutlet weak var organizationPhoneNumberLabel: UILabel!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var deleteAccountButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        deleteAccountButton.titleLabel?.attributedText = NSAttributedString(string: "Удалить аккаунт", attributes: [.underlineStyle: NSUnderlineStyle.thick.rawValue])

        self.updateUI()

        navigationItem.title = "Профиль"
    }
    
    override func viewWillLayoutSubviews() {
        addPhotoButton.layer.cornerRadius = addPhotoButton.frame.height / 2
        organizationImageView.layer.cornerRadius = organizationImageView.frame.height / 2
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

extension OrganizationProfileViewBeta: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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

        organizationImageView.image = info[.editedImage] as? UIImage
        organizationImageView.contentMode = .scaleAspectFill
        organizationImageView.clipsToBounds = true

        dismiss(animated: true)
    }
}

extension OrganizationProfileViewBeta: OrganizationProfileViewInput {
    
}

extension OrganizationProfileViewBeta {
    private func updateUI() {
        updateUIName()
        updateUIINN()
        updateUIContactName()
        updateUIPhoneNumber()
        updateUIEmail()
    }

    private func updateUIName() {
        if self.isViewLoaded {
            self.organizationNameLabel.text = self.organizationName
        }
    }
    private func updateUIINN() {
        if self.isViewLoaded {
            self.organizationINNLabel.text = self.organizationINN
        }
    }
    private func updateUIContactName() {
        if self.isViewLoaded {
            self.organizationContactNameLabel.text = self.organizationContactName
        }
    }
    private func updateUIPhoneNumber() {
        if self.isViewLoaded {
            self.organizationPhoneNumberLabel.text = self.organizationPhoneNumber
        }
    }
    private func updateUIEmail() {
        if self.isViewLoaded {
            self.organizationEmailLabel.text = self.email
        }
    }

}
