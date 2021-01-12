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

final class MemberProfileViewAlpha: UIViewController {
    var output: MemberProfileViewOutput?

    var memberFirstName: String?
    var memberLastName: String?
    var userEmail: String? { didSet { self.updateUIEmail() } }
    var organizationName: String? { didSet { self.updateUIOrganization() } }

    private lazy var memberImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "exampleProfile")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var addPhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "addFoto"), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
        button.addTarget(self, action: #selector(MemberProfileViewAlpha.addPhotoButtonTouchUpInside), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var memberNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont(name: "Montserrat-SemiBold", size: 36.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var memberOrganizationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        label.font = UIFont(name: "Montserrat-Medium", size: 16.0)
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

    private lazy var memberEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "Почта:"
        label.font = UIFont(name: "Montserrat-Regular", size: 16.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 0.7006635274)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var memberEmail: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 18.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var memberPhoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Телефон:"
        label.font = UIFont(name: "Montserrat-Regular", size: 16.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 0.7006635274)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var memberPhoneNumber: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 18.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var editMemberProfileButton: UIButton = {
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
        super.viewDidLoad()
        self.layout()
        self.updateUI()

        view.backgroundColor = .white
        navigationItem.title = "Профиль"

        editMemberProfileButton.titleLabel?.attributedText = NSAttributedString(string: "Редактировать аккаунт", attributes: [.underlineStyle: NSUnderlineStyle.thick.rawValue])

        memberNameLabel.text = "\(memberFirstName ?? "") \(memberLastName ?? "")"
    }

    override func viewWillLayoutSubviews() {
        addPhotoButton.layer.cornerRadius = addPhotoButton.frame.height / 2
        memberImageView.layer.cornerRadius = memberImageView.frame.height / 2
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
extension MemberProfileViewAlpha {
    private func layout() {
        layoutMemberImageView(in: self.view)
        layoutAddPhotoButton(in: self.view)
        layoutMemberNameLabel(in: self.view)
        layoutMemberOrganizationNameLabel(in: self.view)
        layoutBackgroundView(in: self.view)
        layoutFirstSeparator(in: self.backgroundView)
        layoutSecondSeparator(in: self.backgroundView)
        layoutThirdSeparator(in: self.backgroundView)
        layoutMemberEmailLabel(in: self.backgroundView)
        layoutMemberEmail(in: self.backgroundView)
        layoutMemberPhoneNumberLabel(in: self.backgroundView)
        layoutMemberPhoneNumber(in: self.backgroundView)
        layoutEditProfileButton(in: self.view)
    }

    private func layoutMemberImageView(in container: UIView) {
        let imageView = memberImageView
        container.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 50.0),
            imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: container.heightAnchor, multiplier: 75/448),
            imageView.heightAnchor.constraint(equalTo: self.memberImageView.widthAnchor, multiplier: 1)
        ])
    }

    private func layoutAddPhotoButton(in container: UIView) {
        let button = addPhotoButton
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.rightAnchor.constraint(equalTo: self.memberImageView.rightAnchor),
            button.bottomAnchor.constraint(equalTo: self.memberImageView.bottomAnchor, constant: -8.0),
            button.widthAnchor.constraint(equalTo: container.heightAnchor, multiplier: 5/128),
            button.heightAnchor.constraint(equalTo: self.addPhotoButton.widthAnchor, multiplier: 1)
        ])
    }

    private func layoutMemberNameLabel(in container: UIView) {
        let label = memberNameLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -30.0),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 30.0),
            label.topAnchor.constraint(equalTo: self.memberImageView.bottomAnchor, constant: 20.0)
        ])
    }

    private func layoutMemberOrganizationNameLabel(in container: UIView) {
        let label = memberOrganizationLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.memberNameLabel.leftAnchor),
            label.rightAnchor.constraint(equalTo: self.memberNameLabel.rightAnchor),
            label.topAnchor.constraint(equalTo: self.memberNameLabel.bottomAnchor, constant: 0)
        ])
    }

    private func layoutBackgroundView(in container: UIView) {
        let background = backgroundView
        container.addSubview(background)
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: self.memberOrganizationLabel.bottomAnchor, constant: 20.0),
            background.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            background.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            background.heightAnchor.constraint(equalToConstant: 105.0)
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

    private func layoutMemberEmailLabel(in container: UIView) {
        let label = memberEmailLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.firstSeparator.leftAnchor),
            label.topAnchor.constraint(equalTo: self.firstSeparator.bottomAnchor, constant: 16.0)
        ])
    }

    private func layoutMemberEmail(in container: UIView) {
        let label = memberEmail
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor, constant: -20.0),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: self.memberEmailLabel.trailingAnchor, constant: 15.0),
            label.centerYAnchor.constraint(equalTo: self.memberEmailLabel.centerYAnchor)
        ])
    }

    private func layoutMemberPhoneNumberLabel(in container: UIView) {
        let label = memberPhoneNumberLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.secondSeparator.leftAnchor),
            label.topAnchor.constraint(equalTo: self.secondSeparator.bottomAnchor, constant: 16.0)
        ])
    }

    private func layoutMemberPhoneNumber(in container: UIView) {
        let label = memberPhoneNumber
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor, constant: -20.0),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: self.memberPhoneNumberLabel.trailingAnchor, constant: 15.0),
            label.centerYAnchor.constraint(equalTo: self.memberPhoneNumberLabel.centerYAnchor)
        ])
    }

    private func layoutEditProfileButton(in container: UIView) {
        let button = editMemberProfileButton
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor, constant: -30.0),
            button.centerXAnchor.constraint(equalTo: container.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}

// MARK: - UIImagePickerControllerDelegate
extension MemberProfileViewAlpha: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

        memberImageView.image = info[.editedImage] as? UIImage
        memberImageView.contentMode = .scaleAspectFill
        memberImageView.clipsToBounds = true

        dismiss(animated: true)
    }
}

extension MemberProfileViewAlpha {
    private func updateUI() {
        updateUIEmail()
        updateUIOrganization()
    }

    private func updateUIEmail() {
        if self.isViewLoaded {
            self.memberEmail.text = self.userEmail
        }
    }

    public func updateUIOrganization() {
        if self.isViewLoaded {
            self.memberOrganizationLabel.text = self.organizationName
        }
    }
}

extension MemberProfileViewAlpha: MemberProfileViewInput {
    
}
