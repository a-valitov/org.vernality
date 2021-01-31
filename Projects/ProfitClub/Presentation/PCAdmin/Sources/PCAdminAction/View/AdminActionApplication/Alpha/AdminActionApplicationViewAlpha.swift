//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Macbook on 08.01.2021
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
import BundleUtils

final class AdminActionApplicationViewAlpha: UIViewController {
    var output: AdminActionApplicationViewOutput?
    var actionImageUrl: URL? {
        didSet {
            if self.isViewLoaded {
                self.actionImageView.kf.setImage(with: actionImageUrl)
            }
        }
    }
    var actionMessage: String? {
        didSet {
            if self.isViewLoaded {
                self.actionMessageLabel.text = self.actionMessage
            }
        }
    }
    var actionDescription: String? {
        didSet {
            if self.isViewLoaded {
                self.actionDescriptionLabel.text = self.actionDescription
            }
        }
    }
    var organizationName: String? {
        didSet {
            if self.isViewLoaded {
                self.organizationNameLabel.text = self.organizationName
            }
        }
    }
    var actionLink: String?
    var actionStartDate: Date? {
        didSet {
            if self.isViewLoaded {
                self.updateUIActionStartAndEndDate()
            }
        }
    }
    var actionEndDate: Date? {
        didSet {
            if self.isViewLoaded {
                self.updateUIActionStartAndEndDate()
            }
        }
    }
    var supplierName: String?

    private lazy var actionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return imageView
    }()

    private lazy var organizationNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        label.font = UIFont(name: "Montserrat-Bold", size: 22.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var actionMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        label.font = UIFont(name: "Montserrat-Medium", size: 15.0)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var actionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        label.font = UIFont(name: "Montserrat-Regular", size: 12.0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var approveActionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        button.setTitle("Принять", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.9450980392, green: 0.9058823529, blue: 0.8941176471, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 15.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var rejectActionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отклонить", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 15.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var actionLinkButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ссылка", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.6040507277), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 12.0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 65.0, bottom: 0, right: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var actionStartAndEndDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.5981110873)
        label.font = UIFont(name: "Montserrat-Medium", size: 12.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        view.backgroundColor = .white
        self.output?.adminActionApplicationDidLoad(view: self)

        #if SWIFT_PACKAGE
        actionLinkButton.setImage(UIImage(named: "Icon", in: Bundle.module, compatibleWith: nil), for: .normal)
        #else
        actionLinkButton.setImage(UIImage(named: "Icon", in: Bundle.pod(Self.self), compatibleWith: nil), for: .normal)
        #endif

        #if SWIFT_PACKAGE
        cancelButton.setImage(UIImage(named: "close_action", in: Bundle.module, compatibleWith: nil), for: .normal)
        #else
        cancelButton.setImage(UIImage(named: "close_action", in: Bundle.pod(Self.self), compatibleWith: nil), for: .normal)
        #endif
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.rejectActionButton.layer.borderWidth = 1
        self.rejectActionButton.layer.borderColor = UIColor.black.cgColor
        self.actionImageView.layer.masksToBounds = true
    }
}

// MARK: - Actions
extension AdminActionApplicationViewAlpha {
    @objc
    private func cancelTouchUpInside(_ sender: Any) {
        dismiss(animated: true)
    }

    @objc
    private func approveActionButtonTouchUpInside(_ sender: Any) {
        output?.adminActionApplication(view: self, userWantsToApprove: sender)
    }

    @objc
    private func rejectActionButtonTouchUpInside(_ sender: Any) {
        output?.adminActionApplication(view: self, userWantsToReject: sender)
    }

    @objc
    private func actionLinkTouchUpInside(_ sender: Any) {
        if let url = URL(string: self.actionLink!) {
            UIApplication.shared.open(url)
        }
    }
}

// MARK: - Setup
extension AdminActionApplicationViewAlpha {
    private func setup() {
        cancelButton.addTarget(self, action: #selector(AdminActionApplicationViewAlpha.cancelTouchUpInside(_:)), for: .touchUpInside)
        approveActionButton.addTarget(self, action: #selector(AdminActionApplicationViewAlpha.approveActionButtonTouchUpInside(_:)), for: .touchUpInside)
        rejectActionButton.addTarget(self, action: #selector(AdminActionApplicationViewAlpha.rejectActionButtonTouchUpInside(_:)), for: .touchUpInside)
        actionLinkButton.addTarget(self, action: #selector(AdminActionApplicationViewAlpha.actionLinkTouchUpInside(_:)), for: .touchUpInside)
    }
}

// MARK: - Layout
extension AdminActionApplicationViewAlpha {
    private func layout() {
        layoutActionImageView(in: self.view)
        layoutCancelButton(in: self.view)
        layoutOrganizationNameLabel(in: self.view)
        layoutActionLinkButton(in: self.view)
        layoutActionMessageLabel(in: self.view)
        layoutActionDescriptionLabel(in: self.view)
        layoutActionStartAndEndDateLabel(in: self.view)
        layoutApproveActionButton(in: self.view)
        layoutRejectActionButton(in: self.view)
    }

    private func layoutActionImageView(in container: UIView) {
        let imageView = actionImageView
        container.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(greaterThanOrEqualTo: self.actionImageView.widthAnchor, multiplier: 89/207)
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
            label.topAnchor.constraint(equalTo: self.actionImageView.bottomAnchor, constant: 20.0)
        ])
    }

    private func layoutActionLinkButton(in container: UIView) {
        let button = actionLinkButton
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            button.topAnchor.constraint(equalTo: self.actionImageView.bottomAnchor, constant: 26.0),
            button.widthAnchor.constraint(equalToConstant: 61.0),
            button.heightAnchor.constraint(equalToConstant: 16.0)
        ])
    }

    private func layoutActionMessageLabel(in container: UIView) {
        let label = actionMessageLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.organizationNameLabel.leftAnchor),
            label.rightAnchor.constraint(equalTo: self.actionLinkButton.rightAnchor),
            label.topAnchor.constraint(equalTo: self.organizationNameLabel.bottomAnchor, constant: 3.0),
            label.heightAnchor.constraint(lessThanOrEqualToConstant: 40.0)
        ])
    }

    private func layoutActionDescriptionLabel(in container: UIView) {
        let label = actionDescriptionLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.organizationNameLabel.leftAnchor),
            label.rightAnchor.constraint(equalTo: self.actionLinkButton.rightAnchor),
            label.topAnchor.constraint(equalTo: self.actionMessageLabel.bottomAnchor, constant: 10.0),
            label.heightAnchor.constraint(lessThanOrEqualToConstant: 100.0)
        ])
    }

    private func layoutActionStartAndEndDateLabel(in container: UIView) {
        let label = actionStartAndEndDateLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.organizationNameLabel.leftAnchor),
            label.rightAnchor.constraint(equalTo: self.actionLinkButton.rightAnchor),
            label.topAnchor.constraint(equalTo: self.actionDescriptionLabel.bottomAnchor, constant: 10.0)
        ])
    }

    private func layoutApproveActionButton(in container: UIView) {
        let button = approveActionButton
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.leftAnchor.constraint(equalTo: self.organizationNameLabel.leftAnchor),
            button.rightAnchor.constraint(equalTo: self.actionLinkButton.rightAnchor),
            button.topAnchor.constraint(equalTo: self.actionStartAndEndDateLabel.bottomAnchor, constant: 20.0),
            button.heightAnchor.constraint(equalToConstant: 52.0)
        ])
    }

    private func layoutRejectActionButton(in container: UIView) {
        let button = rejectActionButton
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.leftAnchor.constraint(equalTo: self.organizationNameLabel.leftAnchor),
            button.rightAnchor.constraint(equalTo: self.actionLinkButton.rightAnchor),
            button.topAnchor.constraint(equalTo: self.approveActionButton.bottomAnchor, constant: 15.0),
            button.heightAnchor.constraint(equalToConstant: 52.0),
            button.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor, constant: -20.0)
        ])
    }
}

extension AdminActionApplicationViewAlpha {
    private func updateUI() {
        self.updateUIActionStartAndEndDate()
    }

    private func updateUIActionStartAndEndDate() {
        if self.isViewLoaded {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            if let actionStartDate = self.actionStartDate,
               let actionEndDate = self.actionEndDate {
                self.actionStartAndEndDateLabel.text = dateFormatter.string(from: actionStartDate) + "-" + dateFormatter.string(from: actionEndDate)
            } else if let actionEndDate = self.actionEndDate {
                self.actionStartAndEndDateLabel.text = dateFormatter.string(from: actionEndDate)
            } else if let actionStartDate = self.actionStartDate {
                self.actionStartAndEndDateLabel.text = dateFormatter.string(from: actionStartDate)
            } else {
                self.actionStartAndEndDateLabel.text = nil
            }
        }
    }
}


extension AdminActionApplicationViewAlpha: AdminActionApplicationViewInput {

}

