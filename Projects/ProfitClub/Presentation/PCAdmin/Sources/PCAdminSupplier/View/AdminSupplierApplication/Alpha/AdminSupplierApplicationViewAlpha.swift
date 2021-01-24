//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Macbook on 07.01.2021
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
import Kingfisher

final class AdminSupplierApplicationViewAlpha: UIViewController {
    var output: AdminSupplierApplicationViewOutput?
    var supplierName: String? {
        didSet {
            if self.isViewLoaded {
                self.supplierNameLabel.text = self.supplierName
            }
        }
    }

    var supplierContactName: String? {
        didSet {
            if self.isViewLoaded {
                self.supplierContactNameLabel.text = self.supplierContactName
            }
        }
    }

    var supplierINN: String? {
        didSet {
            if self.isViewLoaded {
                self.supplierINNInfoLabel.text = self.supplierINN
            }
        }
    }

    var supplierPhoneNumber: String? {
        didSet {
            if self.isViewLoaded {
                self.supplierPhoneNumberInfoLabel.text = self.supplierPhoneNumber
            }
        }
    }
    var supplierImageUrl: URL? {
        didSet {
            if self.isViewLoaded {
                self.supplierImageView.kf.setImage(with: supplierImageUrl)
            }
        }
    }

    private lazy var supplierImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return imageView
    }()

    private lazy var supplierNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        label.font = UIFont(name: "Montserrat-Bold", size: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var supplierFIOLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 0.7043824914)
        label.text = "ФИО:"
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var supplierContactNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var supplierINNLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 0.7043824914)
        label.text = "ИНН:"
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var supplierINNInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var supplierPhoneNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 0.7043824914)
        label.text = "Номер телефона:"
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var supplierPhoneNumberInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var supplierDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.5981110873)
        label.text = "24.03.2020"
        label.font = UIFont(name: "Montserrat-Medium", size: 12.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var approveSupplierButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        button.setTitle("Принять", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.9450980392, green: 0.9058823529, blue: 0.8941176471, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 15.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var rejectSupplierButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отклонить", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 15.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton()
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
        self.output?.adminSupplierApplicationDidLoad(view: self)

        #if SWIFT_PACKAGE
        cancelButton.setImage(UIImage(named: "X", in: Bundle.module, compatibleWith: nil), for: .normal)
        #else
        cancelButton.setImage(UIImage(named: "X", in: Bundle(for: Self.self), compatibleWith: nil), for: .normal)
        #endif
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.rejectSupplierButton.layer.borderWidth = 1
        self.rejectSupplierButton.layer.borderColor = UIColor.black.cgColor
        self.supplierImageView.layer.masksToBounds = true
    }
}

// MARK: - Actions
extension AdminSupplierApplicationViewAlpha {
    @objc
    private func cancelTouchUpInside(_ sender: Any) {
        dismiss(animated: true)
    }

    @objc
    private func approveSupplierButtonTouchUpInside(_ sender: Any) {
        output?.adminSupplierApplication(view: self, userWantsToApprove: sender)
    }

    @objc
    private func rejectSupplierButtonTouchUpInside(_ sender: Any) {
        output?.adminSupplierApplication(view: self, userWantsToReject: sender)
    }
}

// MARK: - Setup
extension AdminSupplierApplicationViewAlpha {
    private func setup() {
        cancelButton.addTarget(self, action: #selector(AdminSupplierApplicationViewAlpha.cancelTouchUpInside(_:)), for: .touchUpInside)
        approveSupplierButton.addTarget(self, action: #selector(AdminSupplierApplicationViewAlpha.approveSupplierButtonTouchUpInside(_:)), for: .touchUpInside)
        rejectSupplierButton.addTarget(self, action: #selector(AdminSupplierApplicationViewAlpha.rejectSupplierButtonTouchUpInside(_:)), for: .touchUpInside)
    }
}

// MARK: - Layout
extension AdminSupplierApplicationViewAlpha {
    private func layout() {
        layoutSupplierImageView(in: self.view)
        layoutCancelButton(in: self.view)
        layoutSupplierNameLabel(in: self.view)
        layoutSupplierDateLabel(in: self.view)
        layoutSupplierFIOLabel(in: self.view)
        layoutSupplierContactNameLabel(in: self.view)
        layoutSupplierINNLabel(in: self.view)
        layoutSupplierINNInfoLabel(in: self.view)
        layoutSupplierPhoneNumberLabel(in: self.view)
        layoutSupplierPhoneNumberInfoLabel(in: self.view)
        layoutApproveSupplierButton(in: self.view)
        layoutRejectSupplierButton(in: self.view)
    }

    private func layoutSupplierImageView(in container: UIView) {
        let imageView = supplierImageView
        container.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(greaterThanOrEqualTo: self.supplierImageView.widthAnchor, multiplier: 89/207)
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

    private func layoutSupplierNameLabel(in container: UIView) {
        let label = supplierNameLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            label.topAnchor.constraint(equalTo: self.supplierImageView.bottomAnchor, constant: 20.0)
        ])
    }

    private func layoutSupplierDateLabel(in container: UIView) {
        let label = supplierDateLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15.0),
            label.topAnchor.constraint(equalTo: self.supplierImageView.bottomAnchor, constant: 25.0)
        ])
    }

    private func layoutSupplierFIOLabel(in container: UIView) {
        let label = supplierFIOLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.supplierNameLabel.leftAnchor),
            label.topAnchor.constraint(equalTo: self.supplierNameLabel.bottomAnchor, constant: 10.0),
            label.widthAnchor.constraint(equalToConstant: 34)
        ])
    }

    private func layoutSupplierContactNameLabel(in container: UIView) {
        let label = supplierContactNameLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.supplierFIOLabel.trailingAnchor, constant: 8.0),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 20.0),
            label.centerYAnchor.constraint(equalTo: self.supplierFIOLabel.centerYAnchor)
        ])
    }

    private func layoutSupplierINNLabel(in container: UIView) {
        let label = supplierINNLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.supplierNameLabel.leftAnchor),
            label.topAnchor.constraint(equalTo: self.supplierFIOLabel.bottomAnchor, constant: 8.0),
            label.widthAnchor.constraint(equalToConstant: 33)
        ])
    }

    private func layoutSupplierINNInfoLabel(in container: UIView) {
        let label = supplierINNInfoLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.supplierINNLabel.trailingAnchor, constant: 8.0),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 20.0),
            label.centerYAnchor.constraint(equalTo: self.supplierINNLabel.centerYAnchor)
        ])
    }

    private func layoutSupplierPhoneNumberLabel(in container: UIView) {
        let label = supplierPhoneNumberLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.supplierNameLabel.leftAnchor),
            label.topAnchor.constraint(equalTo: self.supplierINNLabel.bottomAnchor, constant: 8.0),
            label.widthAnchor.constraint(equalToConstant: 109)
        ])
    }

    private func layoutSupplierPhoneNumberInfoLabel(in container: UIView) {
        let label = supplierPhoneNumberInfoLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.supplierPhoneNumberLabel.trailingAnchor, constant: 8.0),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 20.0),
            label.centerYAnchor.constraint(equalTo: self.supplierPhoneNumberLabel.centerYAnchor)
        ])
    }

    private func layoutApproveSupplierButton(in container: UIView) {
        let button = approveSupplierButton
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.leftAnchor.constraint(equalTo: self.supplierNameLabel.leftAnchor),
            button.rightAnchor.constraint(equalTo: self.supplierDateLabel.rightAnchor),
            button.topAnchor.constraint(equalTo: self.supplierPhoneNumberInfoLabel.bottomAnchor, constant: 30.0),
            button.heightAnchor.constraint(equalToConstant: 52.0)
        ])
    }

    private func layoutRejectSupplierButton(in container: UIView) {
        let button = rejectSupplierButton
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.leftAnchor.constraint(equalTo: self.supplierNameLabel.leftAnchor),
            button.rightAnchor.constraint(equalTo: self.supplierDateLabel.rightAnchor),
            button.topAnchor.constraint(equalTo: self.approveSupplierButton.bottomAnchor, constant: 15.0),
            button.heightAnchor.constraint(equalToConstant: 52.0),
            button.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor, constant: -20.0)
        ])
    }
}

extension AdminSupplierApplicationViewAlpha: AdminSupplierApplicationViewInput {

}
