//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 30.10.2020
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
import MobileCoreServices

final class SupplierCommercialOfferBeta: UIViewController {
    var output: SupplierCommercialOfferOutput?

    var message: String? {
        if self.isViewLoaded {
            return self.messageTextView.text
        } else {
            return nil
        }
    }

    var image: UIImage? {
        if self.isViewLoaded {
            return self.commercialOfferImageView.image
        } else {
            return nil
        }
    }

    var attachment: Data?
    
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var commercialOfferImageView: UIImageView!
    @IBOutlet weak var addCommercialOfferImage: UIButton!
    @IBOutlet weak var attachmentLabel: UILabel!
    
    @IBAction func addCommercialOfferImageTouchUpInside(_ sender: Any) {

        let cameraIcon = #imageLiteral(resourceName: "camera")
        let photoIcon = #imageLiteral(resourceName: "photo")

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

    @IBAction func attachFileTouchUpInside(_ sender: UIButton) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .fullScreen
        UINavigationBar.appearance().tintColor = .blue
        self.present(documentPicker, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextView.delegate = self
        messageTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 20)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if commercialOfferImageView.image != nil {
            addCommercialOfferImage.setTitle("Заменить фото", for: .normal)
            addCommercialOfferImage.setTitleColor(.white, for: .normal)
            addCommercialOfferImage.imageView?.isHidden = true
        }
        UINavigationBar.appearance().tintColor = .white
    }
}

extension SupplierCommercialOfferBeta: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Введите сообщение" {
            textView.text = ""
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Введите сообщение"
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

extension SupplierCommercialOfferBeta: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        commercialOfferImageView.image = info[.editedImage] as? UIImage
        commercialOfferImageView.contentMode = .scaleAspectFill
        commercialOfferImageView.clipsToBounds = true

        dismiss(animated: true)
    }
}

extension SupplierCommercialOfferBeta: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else {
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        self.attachment = data
        self.attachmentLabel.text = "Приложение: " + url.lastPathComponent
        self.attachmentLabel.isHidden = false
    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true)
    }
}

extension SupplierCommercialOfferBeta: SupplierCommercialOfferInput {
    
}
