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

    var attachments: [Data] = []
    var attachmentNames: [String] = []

    private var cameraIcon: UIImage?
    private var photoIcon: UIImage?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var commercialOfferImageView: UIImageView!
    @IBOutlet weak var addCommercialOfferImage: UIButton!
    
    @IBAction func addCommercialOfferImageTouchUpInside(_ sender: Any) {

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

    @IBAction func createCommerialOfferButtonTouchUpInside(_ sender: Any) {
        self.output?.supplierCommercialOfferDidFinish(view: self)
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

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "barItem"), style: .plain, target: self, action: #selector(menuBarButtonItemAction))
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

    @objc private func menuBarButtonItemAction(_ sender: Any) {
        self.output?.supplierCommercialOffer(view: self, tappenOn: sender)
    }
}

extension SupplierCommercialOfferBeta: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Введите название предложения" {
            textView.text = ""
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Введите название предложения"
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
        addCommercialOfferImage.setImage(nil, for: .normal)
        addCommercialOfferImage.setTitle("Заменить фото", for: .normal)
        addCommercialOfferImage.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)

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
        do {
            let resources = try url.resourceValues(forKeys: [.fileSizeKey])
            let fileSize = resources.fileSize!
            if fileSize <= 10000000 {
                self.attachments.append(data)
                self.attachmentNames.append(url.lastPathComponent)
                collectionView.reloadData()
            } else {
                let alert = UIAlertController(title: "Error", message: "Your file is exceeds 10mb", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(okAction)
                present(alert, animated: true)
            }
        } catch {
            print("Error")
        }
    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true)
    }
}

extension SupplierCommercialOfferBeta: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attachments.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fileCell", for: indexPath) as! FileCollectionViewCell

        cell.fileNameLabel.text = attachmentNames[indexPath.row]

        return cell
    }
}

extension SupplierCommercialOfferBeta: SupplierCommercialOfferInput {
}
