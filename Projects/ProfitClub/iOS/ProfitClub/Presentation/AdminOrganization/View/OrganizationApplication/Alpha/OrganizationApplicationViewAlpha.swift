//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Macbook on 03.01.2021
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

final class OrganizationApplicationViewAlpha: UIViewController {
    var output: OrganizationApplicationViewOutput?
    var organizationName: String? {
        didSet {
            if self.isViewLoaded {
                self.organizationNameLabel.text = self.organizationName
            }
        }
    }

    var organizationContactName: String? {
        didSet {
            if self.isViewLoaded {
                self.organizationContactNameLabel.text = self.organizationContactName
            }
        }
    }

    var organizationINN: String? {
        didSet {
            if self.isViewLoaded {
                self.organizationINNInfoLabel.text = self.organizationINN
            }
        }
    }

    var organizationPhoneNumber: String? {
        didSet {
            if self.isViewLoaded {
                self.organizationPhoneNumberInfoLabel.text = self.organizationPhoneNumber
            }
        }
    }

    private lazy var organizationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "Mask Group")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return imageView
    }()

    private lazy var organizationNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        label.font = UIFont(name: "Montserrat-Bold", size: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var organizationFIOLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 0.7043824914)
        label.text = "ФИО:"
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var organizationContactNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var organizationINNLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 0.7043824914)
        label.text = "ИНН:"
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var organizationINNInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var organizationPhoneNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 0.7043824914)
        label.text = "Номер телефона:"
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var organizationPhoneNumberInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var organizationDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.5981110873)
        label.text = "24.03.2020"
        label.font = UIFont(name: "Montserrat-Medium", size: 12.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var approveOrganizationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        button.setTitle("Принять", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.9450980392, green: 0.9058823529, blue: 0.8941176471, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 15.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var rejectOrganizationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отклонить", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 15.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "X"), for: .normal)
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
        layout()
        setup()
        view.backgroundColor = .white
        self.output?.organizationApplicationDidLoad(view: self)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.rejectOrganizationButton.layer.borderWidth = 1
        self.rejectOrganizationButton.layer.borderColor = UIColor.black.cgColor
        self.organizationImageView.layer.masksToBounds = true
    }
}

// MARK: - Actions
extension OrganizationApplicationViewAlpha {
    @objc
    private func cancelTouchUpInside(_ sender: Any) {
        dismiss(animated: true)
    }

    @objc
    private func approveOrganizationButtonTouchUpInside(_ sender: Any) {
        output?.organizationApplication(view: self, userWantsToApprove: sender)
    }

    @objc
    private func rejectOrganizationButtonTouchUpInside(_ sender: Any) {
        output?.organizationApplication(view: self, userWantsToReject: sender)
    }
}

// MARK: - Setup
extension OrganizationApplicationViewAlpha {
    private func setup() {
        cancelButton.addTarget(self, action: #selector(OrganizationApplicationViewAlpha.cancelTouchUpInside(_:)), for: .touchUpInside)
        approveOrganizationButton.addTarget(self, action: #selector(OrganizationApplicationViewAlpha.approveOrganizationButtonTouchUpInside(_:)), for: .touchUpInside)
        rejectOrganizationButton.addTarget(self, action: #selector(OrganizationApplicationViewAlpha.rejectOrganizationButtonTouchUpInside(_:)), for: .touchUpInside)
    }
}

// MARK: - Layout
extension OrganizationApplicationViewAlpha {
    private func layout() {
        layoutOrganizationImageView(in: self.view)
        layoutCancelButton(in: self.view)
        layoutOrganizationNameLabel(in: self.view)
        layoutOrganizationDateLabel(in: self.view)
        layoutOrganizationFIOLabel(in: self.view)
        layoutOrganizationContactNameLabel(in: self.view)
        layoutOrganizationINNLabel(in: self.view)
        layoutOrganizationINNInfoLabel(in: self.view)
        layoutOrganizationPhoneNumberLabel(in: self.view)
        layoutOrganizationPhoneNumberInfoLabel(in: self.view)
        layoutApproveOrganizationButton(in: self.view)
        layoutRejectOrganizationButton(in: self.view)
    }

    private func layoutOrganizationImageView(in container: UIView) {
        let imageView = organizationImageView
        container.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(greaterThanOrEqualTo: self.organizationImageView.widthAnchor, multiplier: 89/207)
        ])
    }

    private func layoutCancelButton(in container: UIView) {
        let button = cancelButton
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            button.topAnchor.constraint(equalTo: container.topAnchor, constant: 14.0)
        ])
    }

    private func layoutOrganizationNameLabel(in container: UIView) {
        let label = organizationNameLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            label.topAnchor.constraint(equalTo: self.organizationImageView.bottomAnchor, constant: 20.0)
        ])
    }

    private func layoutOrganizationDateLabel(in container: UIView) {
        let label = organizationDateLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15.0),
            label.topAnchor.constraint(equalTo: self.organizationImageView.bottomAnchor, constant: 25.0)
        ])
    }

    private func layoutOrganizationFIOLabel(in container: UIView) {
        let label = organizationFIOLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.organizationNameLabel.leftAnchor),
            label.topAnchor.constraint(equalTo: self.organizationNameLabel.bottomAnchor, constant: 10.0),
            label.widthAnchor.constraint(equalToConstant: 34)
        ])
    }

    private func layoutOrganizationContactNameLabel(in container: UIView) {
        let label = organizationContactNameLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.organizationFIOLabel.trailingAnchor, constant: 8.0),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 20.0),
            label.centerYAnchor.constraint(equalTo: self.organizationFIOLabel.centerYAnchor)
        ])
    }

    private func layoutOrganizationINNLabel(in container: UIView) {
        let label = organizationINNLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.organizationNameLabel.leftAnchor),
            label.topAnchor.constraint(equalTo: self.organizationFIOLabel.bottomAnchor, constant: 8.0),
            label.widthAnchor.constraint(equalToConstant: 33)
        ])
    }

    private func layoutOrganizationINNInfoLabel(in container: UIView) {
        let label = organizationINNInfoLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.organizationINNLabel.trailingAnchor, constant: 8.0),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 20.0),
            label.centerYAnchor.constraint(equalTo: self.organizationINNLabel.centerYAnchor)
        ])
    }

    private func layoutOrganizationPhoneNumberLabel(in container: UIView) {
        let label = organizationPhoneNumberLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.organizationNameLabel.leftAnchor),
            label.topAnchor.constraint(equalTo: self.organizationINNLabel.bottomAnchor, constant: 8.0),
            label.widthAnchor.constraint(equalToConstant: 109)
        ])
    }

    private func layoutOrganizationPhoneNumberInfoLabel(in container: UIView) {
        let label = organizationPhoneNumberInfoLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.organizationPhoneNumberLabel.trailingAnchor, constant: 8.0),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 20.0),
            label.centerYAnchor.constraint(equalTo: self.organizationPhoneNumberLabel.centerYAnchor)
        ])
    }

    private func layoutApproveOrganizationButton(in container: UIView) {
        let button = approveOrganizationButton
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.leftAnchor.constraint(equalTo: self.organizationNameLabel.leftAnchor),
            button.rightAnchor.constraint(equalTo: self.organizationDateLabel.rightAnchor),
            button.topAnchor.constraint(equalTo: self.organizationPhoneNumberInfoLabel.bottomAnchor, constant: 30.0),
            button.heightAnchor.constraint(equalToConstant: 52.0)
        ])
    }

    private func layoutRejectOrganizationButton(in container: UIView) {
        let button = rejectOrganizationButton
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.leftAnchor.constraint(equalTo: self.organizationNameLabel.leftAnchor),
            button.rightAnchor.constraint(equalTo: self.organizationDateLabel.rightAnchor),
            button.topAnchor.constraint(equalTo: self.approveOrganizationButton.bottomAnchor, constant: 15.0),
            button.heightAnchor.constraint(equalToConstant: 52.0),
            button.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor, constant: -20.0)
        ])
    }
}

extension OrganizationApplicationViewAlpha: OrganizationApplicationViewInput {

}
