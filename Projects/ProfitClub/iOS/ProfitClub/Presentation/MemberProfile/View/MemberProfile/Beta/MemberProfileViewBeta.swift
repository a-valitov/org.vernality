//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 15.11.2020
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

final class MemberProfileViewBeta: UIViewController {
    var output: MemberProfileViewOutput?

    @IBOutlet weak var memberImageView: UIImageView!
    @IBOutlet weak var memberNameLabel: UILabel!
    @IBOutlet weak var memberOrganizationNameLabel: UILabel!
    @IBOutlet weak var memberEmailLabel: UILabel!
    @IBOutlet weak var memberPhoneNumberLabel: UILabel!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var deleteAccountButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        deleteAccountButton.titleLabel?.attributedText = NSAttributedString(string: "Удалить аккаунт", attributes: [.underlineStyle: NSUnderlineStyle.thick.rawValue])

    }

    override func viewWillLayoutSubviews() {
        addPhotoButton.layer.cornerRadius = addPhotoButton.frame.height / 2
        memberImageView.layer.cornerRadius = memberImageView.frame.height / 2
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

extension MemberProfileViewBeta: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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

        memberImageView.image = info[.editedImage] as? UIImage
        memberImageView.contentMode = .scaleAspectFill
        memberImageView.clipsToBounds = true

        dismiss(animated: true)
    }
}

extension MemberProfileViewBeta: MemberProfileViewInput {

}
