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

final class PastActionViewAlpha: UIViewController {
    var output: PastActionViewOutput?
    var pastActionImageUrl: URL? {
        didSet {
            self.updateUIActionImageUrl()
        }
    }
    var pastActionMessage: String? {
        didSet {
            self.updateUIActionMessage()
        }
    }
    var pastActionDescription: String? {
        didSet {
            self.updateUIActionDescription()
        }
    }
    var organizationName: String? {
        didSet {
            self.updateUIOrganizationName()
        }
    }
    var pastActionStartDate: Date? {
        didSet {
            self.updateUIActionStartAndEndDate()
        }
    }
    var pastActionEndDate: Date? {
        didSet {
            self.updateUIActionStartAndEndDate()
        }
    }

    private lazy var pastActionImageView: UIImageView = {
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

    private lazy var pastActionMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        label.font = UIFont(name: "Montserrat-Medium", size: 15.0)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var pastActionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        label.font = UIFont(name: "Montserrat-Regular", size: 12.0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var actionPassedLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.6040507277)
        label.font = UIFont(name: "Montserrat-Medium", size: 12.0)
        label.text = "Акция прошла"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(PastActionViewAlpha.cancelButtonTouchUpInside), for: .touchUpInside)
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
        self.updateUI()
        self.layout()

        #if SWIFT_PACKAGE
        cancelButton.setImage(UIImage(named: "X", in: Bundle.module, compatibleWith: nil), for: .normal)
        #else
        cancelButton.setImage(UIImage(named: "X", in: Bundle(for: Self.self), compatibleWith: nil), for: .normal)
        #endif

    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.pastActionImageView.layer.masksToBounds = true
    }

    @objc private func cancelButtonTouchUpInside() {
        dismiss(animated: true)
    }
}

// MARK: - Layout
extension PastActionViewAlpha {
    private func layout() {
        layoutPastActionImageView(in: self.view)
        layoutCancelButton(in: self.view)
        layoutOrganizationNameLabel(in: self.view)
        layoutActionPassedLabel(in: self.view)
        layoutPastActionMessageLabel(in: self.view)
        layoutPastActionDescriptionLabel(in: self.view)
        layoutActionStartAndEndDateLabel(in: self.view)
    }

    private func layoutPastActionImageView(in container: UIView) {
        let imageView = pastActionImageView
        container.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(greaterThanOrEqualTo: self.pastActionImageView.widthAnchor, multiplier: 89/207)
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
            label.topAnchor.constraint(equalTo: self.pastActionImageView.bottomAnchor, constant: 20.0)
        ])
    }

    private func layoutActionPassedLabel(in container: UIView) {
        let label = actionPassedLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            label.topAnchor.constraint(equalTo: self.pastActionImageView.bottomAnchor, constant: 26.0)
        ])
    }

    private func layoutPastActionMessageLabel(in container: UIView) {
        let label = pastActionMessageLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.organizationNameLabel.leftAnchor),
            label.rightAnchor.constraint(equalTo: self.actionPassedLabel.rightAnchor),
            label.topAnchor.constraint(equalTo: self.organizationNameLabel.bottomAnchor, constant: 3.0),
            label.heightAnchor.constraint(lessThanOrEqualToConstant: 40.0)
        ])
    }

    private func layoutPastActionDescriptionLabel(in container: UIView) {
        let label = pastActionDescriptionLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.organizationNameLabel.leftAnchor),
            label.rightAnchor.constraint(equalTo: self.actionPassedLabel.rightAnchor),
            label.topAnchor.constraint(equalTo: self.pastActionMessageLabel.bottomAnchor, constant: 10.0),
            label.heightAnchor.constraint(lessThanOrEqualToConstant: 100.0)
        ])
    }

    private func layoutActionStartAndEndDateLabel(in container: UIView) {
        let label = actionStartAndEndDate
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.organizationNameLabel.leftAnchor),
            label.rightAnchor.constraint(equalTo: self.actionPassedLabel.rightAnchor),
            label.topAnchor.constraint(equalTo: self.pastActionDescriptionLabel.bottomAnchor, constant: 10.0),
            label.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor, constant: -20.0)
        ])
    }
}

// MARK: - UpdateUI
extension PastActionViewAlpha {
    private func updateUI() {
        self.updateUIActionImageUrl()
        self.updateUIActionMessage()
        self.updateUIActionDescription()
        self.updateUIOrganizationName()
        self.updateUIActionStartAndEndDate()
    }

    private func updateUIActionImageUrl() {
        if isViewLoaded {
            self.pastActionImageView.kf.setImage(with: pastActionImageUrl)
        }
    }

    private func updateUIActionMessage() {
        if isViewLoaded {
            self.pastActionMessageLabel.text = self.pastActionMessage
        }
    }

    private func updateUIActionDescription() {
        if isViewLoaded {
            self.pastActionDescriptionLabel.text = self.pastActionDescription
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
            if let pastActionStartDate = self.pastActionStartDate,
               let pastActionEndDate = self.pastActionEndDate {
                self.actionStartAndEndDate.text = dateFormatter.string(from: pastActionStartDate) + "-" + dateFormatter.string(from: pastActionEndDate)
            } else if let pastActionEndDate = self.pastActionEndDate {
                self.actionStartAndEndDate.text = dateFormatter.string(from: pastActionEndDate)
            } else if let pastActionStartDate = self.pastActionStartDate {
                self.actionStartAndEndDate.text = dateFormatter.string(from: pastActionStartDate)
            } else {
                self.actionStartAndEndDate.text = nil
            }
        }
    }
}

extension PastActionViewAlpha: PastActionViewInput {
    
}
