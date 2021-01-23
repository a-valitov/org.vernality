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

final class MemberCurrentActionViewAlpha: UIViewController {
    var output: MemberCurrentActionViewOutput?
    var actionImageUrl: URL? {
        didSet {
            self.updateUIActionImageUrl()
        }
    }
    var actionMessage: String? {
        didSet {
            self.updateUIActionMessage()
        }
    }
    var actionDescription: String? {
        didSet {
            self.updateUIActionDescription()
        }
    }
    var organizationName: String? {
        didSet {
            self.updateUIOrganizationName()
        }
    }
    var actionLink: String?
    var actionStartDate: Date? {
        didSet {
            self.updateUIActionStartAndEndDate()
        }
    }
    var actionEndDate: Date? {
        didSet {
            self.updateUIActionStartAndEndDate()
        }
    }

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

    private lazy var actionLinkButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(MemberCurrentActionViewAlpha.actionLinkTouchUpInside(_:)), for: .touchUpInside)
        button.setTitle("Ссылка", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.6040507277), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 12.0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 65.0, bottom: 0, right: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(MemberCurrentActionViewAlpha.cancelTouchUpInside), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var actionStartAndEndDate: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.5981110873)
        label.font = UIFont(name: "Montserrat-Medium", size: 12.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
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
        view.backgroundColor = .white
        self.output?.memberCurrentActionDidLoad(view: self)
        self.updateUI()
        self.layout()

        #if SWIFT_PACKAGE
        actionLinkButton.setImage(UIImage(named: "Icon", in: Bundle.module, compatibleWith: nil), for: .normal)
        #else
        actionLinkButton.setImage(UIImage(named: "Icon", in: Bundle(for: Self.self), compatibleWith: nil), for: .normal)
        #endif

        #if SWIFT_PACKAGE
        cancelButton.setImage(UIImage(named: "X", in: Bundle.module, compatibleWith: nil), for: .normal)
        #else
        cancelButton.setImage(UIImage(named: "X", in: Bundle(for: Self.self), compatibleWith: nil), for: .normal)
        #endif
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.actionImageView.layer.masksToBounds = true
    }

    @objc private func actionLinkTouchUpInside(_ sender: UIButton) {
        if let url = URL(string: actionLink!) {
            UIApplication.shared.open(url)
        }
    }

    @objc private func cancelTouchUpInside() {
        dismiss(animated: true)
    }
}

// MARK: - Update UI
extension MemberCurrentActionViewAlpha {
    private func updateUI() {
        self.updateUIActionImageUrl()
        self.updateUIActionMessage()
        self.updateUIActionDescription()
        self.updateUIOrganizationName()
        self.updateUIActionStartAndEndDate()
    }

    private func updateUIActionImageUrl() {
        if self.isViewLoaded {
            self.actionImageView.kf.setImage(with: actionImageUrl)
        }
    }

    private func updateUIActionMessage() {
        if self.isViewLoaded {
            self.actionMessageLabel.text = self.actionMessage
        }
    }

    private func updateUIActionDescription() {
        if self.isViewLoaded {
            self.actionDescriptionLabel.text = self.actionDescription
        }
    }

    private func updateUIOrganizationName() {
        if self.isViewLoaded {
            self.organizationNameLabel.text = self.organizationName
        }
    }

    private func updateUIActionStartAndEndDate() {
        if self.isViewLoaded {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            if let actionStartDate = self.actionStartDate,
               let actionEndDate = self.actionEndDate {
                self.actionStartAndEndDate.text = dateFormatter.string(from: actionStartDate) + "-" + dateFormatter.string(from: actionEndDate)
            } else if let actionEndDate = self.actionEndDate {
                self.actionStartAndEndDate.text = dateFormatter.string(from: actionEndDate)
            } else if let actionStartDate = self.actionStartDate {
                self.actionStartAndEndDate.text = dateFormatter.string(from: actionStartDate)
            } else {
                self.actionStartAndEndDate.text = nil
            }
        }
    }
}

// MARK: - Layout
extension MemberCurrentActionViewAlpha {
    private func layout() {
        layoutActionImageView(in: self.view)
        layoutCancelButton(in: self.view)
        layoutOrganizationNameLabel(in: self.view)
        layoutActionLinkButton(in: self.view)
        layoutActionMessageLabel(in: self.view)
        layoutActionDescriptionLabel(in: self.view)
        layoutActionStartAndEndDateLabel(in: self.view)
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
        let label = actionStartAndEndDate
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.organizationNameLabel.leftAnchor),
            label.rightAnchor.constraint(equalTo: self.actionLinkButton.rightAnchor),
            label.topAnchor.constraint(equalTo: self.actionDescriptionLabel.bottomAnchor, constant: 10.0),
            label.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor, constant: -20.0)
        ])
    }
}


extension MemberCurrentActionViewAlpha: MemberCurrentActionViewInput {
    
}
