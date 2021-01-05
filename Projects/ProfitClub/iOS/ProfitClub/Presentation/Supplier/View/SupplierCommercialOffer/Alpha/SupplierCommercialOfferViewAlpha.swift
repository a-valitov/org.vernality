//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 27.11.2020
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

final class SupplierCommercialOfferViewAlpha: UIViewController {
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

    private lazy var fileCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15.0, bottom: 0, right: 15.0)
        layout.itemSize = CGSize(width: 50.0, height: 70.0)
        layout.minimumLineSpacing = 15.0
        layout.minimumInteritemSpacing = 10.0
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var commercialOfferImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 0.1450395976)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        button.addTarget(self, action: #selector(SupplierCommercialOfferViewAlpha.addPhotoTouchUpInside(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var messageTextView: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 20.0)
        textView.autocorrectionType = .no
        textView.spellCheckingType = .no
        textView.returnKeyType = .next
        textView.font = UIFont(name: "Montserrat-Regular", size: 12.0)
        textView.textColor = #colorLiteral(red: 0.1298349798, green: 0.1296681762, blue: 0.1242521927, alpha: 0.5)
        textView.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 0.1450395976)
        textView.layer.cornerRadius = 5
        textView.text = "Введите сообщение"
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private lazy var createCommercialOfferButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15.0)
        button.setTitle("Создать коммерческое предложение", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.9450980392, green: 0.9058823529, blue: 0.8941176471, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(SupplierCommercialOfferViewAlpha.createCommercialOfferTouchUpInside(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var attachmentFileButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "attach"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10.0, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(SupplierCommercialOfferViewAlpha.attachFileTouchUpInside(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

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

        fileCollectionView.register(SupplierCommercialOfferViewAlphaFileCell.self, forCellWithReuseIdentifier: SupplierCommercialOfferViewAlphaFileCell.reuseIdentifier)
        fileCollectionView.delegate = self
        fileCollectionView.dataSource = self

        messageTextView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UINavigationBar.appearance().tintColor = .white
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    private func setup() {
        view.backgroundColor = .white

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "barItem"), style: .plain, target: self, action: #selector(menuBarButtonItemAction))
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
        self.output?.supplierCommercialOffer(view: self, tappenOn: sender)
    }

    @objc private func attachFileTouchUpInside(_ sender: UIButton) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .fullScreen
        UINavigationBar.appearance().tintColor = .blue
        self.present(documentPicker, animated: true)
    }

    @objc private func createCommercialOfferTouchUpInside(_ sender: Any) {
        self.output?.supplierCommercialOfferDidFinish(view: self)
    }
}

// MARK: - Layout
extension SupplierCommercialOfferViewAlpha {
    private func layout() {
        layoutCommercialOfferImageView(in: self.view)
        layoutMessageTextView(in: self.view)
        layoutAddPhotoButton(in: self.view)
        layoutAttachmentFileButton(in: self.view)
        layoutCreateCommercialButton(in: self.view)
        layoutCollectionView(in: self.view)
    }

    private func layoutCommercialOfferImageView(in container: UIView) {
        let imageView = commercialOfferImageView
        container.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            imageView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            imageView.heightAnchor.constraint(equalToConstant: 178.0)
        ])
    }

    private func layoutMessageTextView(in container: UIView) {
        let textView = messageTextView
        container.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: self.commercialOfferImageView.bottomAnchor, constant: 15.0),
            textView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            textView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            textView.heightAnchor.constraint(equalToConstant: 109.0)
        ])
    }

    private func layoutAddPhotoButton(in container: UIView) {
        let button = addPhotoButton
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.commercialOfferImageView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.commercialOfferImageView.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 162.0),
            button.widthAnchor.constraint(equalToConstant: 359.0)
        ])
    }

    private func layoutAttachmentFileButton(in container: UIView) {
        let button = attachmentFileButton
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 28.0),
            button.leadingAnchor.constraint(equalTo: self.messageTextView.trailingAnchor, constant: -36.0),
            button.bottomAnchor.constraint(equalTo: self.messageTextView.topAnchor, constant: 26.0)
        ])
    }

    private func layoutCollectionView(in container: UIView) {
        let collectionView = fileCollectionView
        container.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            collectionView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            collectionView.topAnchor.constraint(equalTo: self.messageTextView.bottomAnchor, constant: 15.0),
            collectionView.heightAnchor.constraint(equalToConstant: 70.0)
        ])
    }

    private func layoutCreateCommercialButton(in container: UIView) {
        let button = createCommercialOfferButton
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            button.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor, constant: -20.0),
            button.heightAnchor.constraint(equalToConstant: 52.0)
        ])
    }
}

// MARK: - UIDocumentPickerDelegate
extension SupplierCommercialOfferViewAlpha: UIDocumentPickerDelegate {
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
                fileCollectionView.reloadData()
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

// MARK: - UITextViewDelegate
extension SupplierCommercialOfferViewAlpha: UITextViewDelegate {
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

// MARK: - UIImagePickerControllerDelegate
extension SupplierCommercialOfferViewAlpha: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

// MARK: - UICollectionViewDelegate
extension SupplierCommercialOfferViewAlpha: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attachments.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SupplierCommercialOfferViewAlphaFileCell.reuseIdentifier, for: indexPath) as! SupplierCommercialOfferViewAlphaFileCell

        cell.fileNameLabel.text = attachmentNames[indexPath.row]

        return cell
    }
}

extension SupplierCommercialOfferViewAlpha: SupplierCommercialOfferInput {
}
