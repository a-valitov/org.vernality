//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 28.11.2020
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

final class SupplierProfileViewAlpha: UIViewController {
    var output: SupplierProfileViewOutput?

    var supplierName: String? { didSet { self.updateUIName() } }
    var supplierINN: String? { didSet { self.updateUIINN() } }
    var supplierContactName: String? { didSet { self.updateUIContactName() } }
    var supplierPhoneNumber: String? { didSet { self.updateUIPhoneNumber() } }

    private lazy var supplierImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "supplierProfile")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var addPhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "addFoto"), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
        button.addTarget(self, action: #selector(SupplierProfileViewAlpha.addPhotoButtonTouchUpInside), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var supplierNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont(name: "Montserrat-SemiBold", size: 36.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var backgroundView: UIView = {
        let background = UIView()
        background.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }()

    private lazy var firstSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = #colorLiteral(red: 0.3294117647, green: 0.3294117647, blue: 0.3450980392, alpha: 0.6527183219)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()

    private lazy var secondSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = #colorLiteral(red: 0.3294117647, green: 0.3294117647, blue: 0.3450980392, alpha: 0.6527183219)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()

    private lazy var thirdSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = #colorLiteral(red: 0.3294117647, green: 0.3294117647, blue: 0.3450980392, alpha: 0.6527183219)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()

    private lazy var fourthSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = #colorLiteral(red: 0.3294117647, green: 0.3294117647, blue: 0.3450980392, alpha: 0.6527183219)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()

    private lazy var fifthSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = #colorLiteral(red: 0.3294117647, green: 0.3294117647, blue: 0.3450980392, alpha: 0.6527183219)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()

    private lazy var userEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "Почта:"
        label.font = UIFont(name: "Montserrat-Regular", size: 16.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 0.7006635274)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var userEmail: UILabel = {
        let label = UILabel()
        label.text = "Lena.Kon@yandex.ru"
        label.font = UIFont(name: "Montserrat-Regular", size: 18.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var supplierContact: UILabel = {
        let label = UILabel()
        label.text = "ФИО:"
        label.font = UIFont(name: "Montserrat-Regular", size: 16.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 0.7006635274)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var supplierContactNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Temur Xushvaqtov"
        label.font = UIFont(name: "Montserrat-Regular", size: 18.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var supplierPhone: UILabel = {
        let label = UILabel()
        label.text = "Телефон:"
        label.font = UIFont(name: "Montserrat-Regular", size: 16.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 0.7006635274)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var supplierPhoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "+79502220202"
        label.font = UIFont(name: "Montserrat-Regular", size: 18.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var supplierINNView: UILabel = {
        let label = UILabel()
        label.text = "ИНН:"
        label.font = UIFont(name: "Montserrat-Regular", size: 16.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 0.7006635274)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var supplierINNLabel: UILabel = {
        let label = UILabel()
        label.text = "32132142344234"
        label.font = UIFont(name: "Montserrat-Regular", size: 18.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var editProfileButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14.0)
        button.setTitleColor(#colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1), for: .normal)
        button.setTitle("Редактировать аккаунт", for: .normal)
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
        self.updateUI()
        self.layout()

        view.backgroundColor = .white
        editProfileButton.titleLabel?.attributedText = NSAttributedString(string: "Удалить аккаунт", attributes: [.underlineStyle: NSUnderlineStyle.thick.rawValue])
        navigationItem.title = "Профиль"
    }

    override func viewWillLayoutSubviews() {
        addPhotoButton.layer.cornerRadius = addPhotoButton.frame.height / 2
        supplierImageView.layer.cornerRadius = supplierImageView.frame.height / 2
    }

    @objc private func addPhotoButtonTouchUpInside() {
        let cameraIcon = #imageLiteral(resourceName: "camera")
        let photoIcon = #imageLiteral(resourceName: "photo")

        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        actionSheet.view.tintColor = .black

        let camera = UIAlertAction(title: "Камера", style: .default) { [weak self] _ in
            self?.chooseImagePicker(source: .camera)
        }

        camera.setValue(cameraIcon, forKey: "image")
        camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")

        let photo = UIAlertAction(title: "Фото", style: .default) { [weak self] _ in
            self?.chooseImagePicker(source: .photoLibrary)
        }

        photo.setValue(photoIcon, forKey: "image")
        photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")

        let cancel = UIAlertAction(title: "Отменить", style: .cancel)

        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)

        present(actionSheet, animated: true)
    }
}

// MARK: - Layout
extension SupplierProfileViewAlpha {
    private func layout() {
        layoutImageView(in: self.view)
        layoutAddPhotoButton(in: self.view)
        layoutSupplierNameLabel(in: self.view)
        layoutBackgroundView(in: self.view)
        layoutFirstSeparator(in: self.backgroundView)
        layoutSecondSeparator(in: self.backgroundView)
        layoutThirdSeparator(in: self.backgroundView)
        layoutFourthSeparator(in: self.backgroundView)
        layoutFifthSeparator(in: self.backgroundView)
        layoutSupplierINNView(in: self.backgroundView)
        layoutSupplierINNLabel(in: self.backgroundView)
        layoutSupplierContact(in: self.backgroundView)
        layoutSupplierContactNameLabel(in: self.backgroundView)
        layoutUserEmailLabel(in: self.backgroundView)
        layoutUserEmail(in: self.backgroundView)
        layoutSupplierPhone(in: self.backgroundView)
        layoutSupplierPhoneNumberLabel(in: self.backgroundView)
        layoutEditProfileButton(in: self.view)
    }

    private func layoutImageView(in container: UIView) {
        let imageView = supplierImageView
        container.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 50.0),
            imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: container.heightAnchor, multiplier: 75/448),
            imageView.heightAnchor.constraint(equalTo: self.supplierImageView.widthAnchor, multiplier: 1)
        ])
    }

    private func layoutAddPhotoButton(in container: UIView) {
        let button = addPhotoButton
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.rightAnchor.constraint(equalTo: self.supplierImageView.rightAnchor),
            button.bottomAnchor.constraint(equalTo: self.supplierImageView.bottomAnchor, constant: -8.0),
            button.widthAnchor.constraint(equalTo: container.heightAnchor, multiplier: 5/128),
            button.heightAnchor.constraint(equalTo: self.addPhotoButton.widthAnchor, multiplier: 1)
        ])
    }

    private func layoutSupplierNameLabel(in container: UIView) {
        let label = supplierNameLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -30.0),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 30.0),
            label.topAnchor.constraint(equalTo: self.supplierImageView.bottomAnchor, constant: 20.0)
        ])
    }

    private func layoutBackgroundView(in container: UIView) {
        let background = backgroundView
        container.addSubview(background)
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: self.supplierNameLabel.bottomAnchor, constant: 20.0),
            background.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            background.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            background.heightAnchor.constraint(equalToConstant: 210.0)
        ])
    }

    private func layoutFirstSeparator(in container: UIView) {
        let separator = firstSeparator
        container.addSubview(separator)
        NSLayoutConstraint.activate([
            separator.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor, constant: 0),
            separator.leadingAnchor.constraint(equalTo: self.backgroundView.leadingAnchor, constant: 25.0),
            separator.topAnchor.constraint(equalTo: self.backgroundView.topAnchor, constant: 0),
            separator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }

    private func layoutSecondSeparator(in container: UIView) {
        let separator = secondSeparator
        container.addSubview(separator)
        NSLayoutConstraint.activate([
            separator.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor, constant: 0),
            separator.leadingAnchor.constraint(equalTo: self.backgroundView.leadingAnchor, constant: 25.0),
            separator.topAnchor.constraint(equalTo: self.firstSeparator.topAnchor, constant: 52.0),
            separator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }

    private func layoutThirdSeparator(in container: UIView) {
        let separator = thirdSeparator
        container.addSubview(separator)
        NSLayoutConstraint.activate([
            separator.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor, constant: 0),
            separator.leadingAnchor.constraint(equalTo: self.backgroundView.leadingAnchor, constant: 25.0),
            separator.topAnchor.constraint(equalTo: self.secondSeparator.topAnchor, constant: 52.0),
            separator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }

    private func layoutFourthSeparator(in container: UIView) {
        let separator = fourthSeparator
        container.addSubview(separator)
        NSLayoutConstraint.activate([
            separator.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor, constant: 0),
            separator.leadingAnchor.constraint(equalTo: self.backgroundView.leadingAnchor, constant: 25.0),
            separator.topAnchor.constraint(equalTo: self.thirdSeparator.topAnchor, constant: 52.0),
            separator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }

    private func layoutFifthSeparator(in container: UIView) {
        let separator = fifthSeparator
        container.addSubview(separator)
        NSLayoutConstraint.activate([
            separator.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor, constant: 0),
            separator.leadingAnchor.constraint(equalTo: self.backgroundView.leadingAnchor, constant: 25.0),
            separator.topAnchor.constraint(equalTo: self.fourthSeparator.topAnchor, constant: 52.0),
            separator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }

    private func layoutSupplierINNView(in container: UIView) {
        let label = supplierINNView
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.firstSeparator.leftAnchor),
            label.topAnchor.constraint(equalTo: self.firstSeparator.bottomAnchor, constant: 16.0)
        ])
    }

    private func layoutSupplierINNLabel(in container: UIView) {
        let label = supplierINNLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor, constant: -20.0),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: self.supplierINNView.trailingAnchor, constant: 15.0),
            label.centerYAnchor.constraint(equalTo: self.supplierINNView.centerYAnchor)
        ])
    }

    private func layoutSupplierContact(in container: UIView) {
        let label = supplierContact
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.secondSeparator.leftAnchor),
            label.topAnchor.constraint(equalTo: self.secondSeparator.bottomAnchor, constant: 16.0)
        ])
    }

    private func layoutSupplierContactNameLabel(in container: UIView) {
        let label = supplierContactNameLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor, constant: -20.0),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: self.supplierContact.trailingAnchor, constant: 15.0),
            label.centerYAnchor.constraint(equalTo: self.supplierContact.centerYAnchor)
        ])
    }

    private func layoutUserEmailLabel(in container: UIView) {
        let label = userEmailLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.thirdSeparator.leftAnchor),
            label.topAnchor.constraint(equalTo: self.thirdSeparator.bottomAnchor, constant: 16.0)
        ])
    }

    private func layoutUserEmail(in container: UIView) {
        let label = userEmail
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor, constant: -20.0),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: self.userEmailLabel.trailingAnchor, constant: 15.0),
            label.centerYAnchor.constraint(equalTo: self.userEmailLabel.centerYAnchor)
        ])
    }

    private func layoutSupplierPhone(in container: UIView) {
        let label = supplierPhone
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.fourthSeparator.leftAnchor),
            label.topAnchor.constraint(equalTo: self.fourthSeparator.bottomAnchor, constant: 16.0)
        ])
    }

    private func layoutSupplierPhoneNumberLabel(in container: UIView) {
        let label = supplierPhoneNumberLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor, constant: -20.0),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: self.supplierPhone.trailingAnchor, constant: 15.0),
            label.centerYAnchor.constraint(equalTo: self.supplierPhone.centerYAnchor)
        ])
    }

    private func layoutEditProfileButton(in container: UIView) {
        let button = editProfileButton
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor, constant: -30.0),
            button.centerXAnchor.constraint(equalTo: container.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}

extension SupplierProfileViewAlpha: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func chooseImagePicker(source: UIImagePickerController.SourceType) {
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

extension SupplierProfileViewAlpha {
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
            self.supplierINNLabel.text = self.supplierINN
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

extension SupplierProfileViewAlpha: SupplierProfileViewInput {

}
