//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Macbook on 12.01.2021
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
import QuickLook

final class AdminCommercialOfferApplicationViewAlpha: UIViewController {
    var output: AdminCommercialOfferApplicationViewOutput?
    var commercialOfferImageUrl: URL? {
        didSet {
            if self.isViewLoaded {
                self.commercialOfferImageView.kf.setImage(with: commercialOfferImageUrl)
            }
        }
    }
    var commercialOfferMessage: String? {
        didSet {
            if self.isViewLoaded {
                self.commercialOfferMessageLabel.text = self.commercialOfferMessage
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
    var attachmentNames: [String] = []
    var attachmentFileUrl: URL?
    var supplierName: String?

    private lazy var commercialOfferImageView: UIImageView = {
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
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()

    private lazy var commercialOfferMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        label.font = UIFont(name: "Montserrat-Regular", size: 12.0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()

    private lazy var approveCommercialOffer: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        button.setTitle("Одобрить", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.9450980392, green: 0.9058823529, blue: 0.8941176471, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 15.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var rejectCommercialOffer: UIButton = {
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

    private lazy var commercialOfferCreatedDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.5981110873)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        label.text = dateFormatter.string(from: Date())
        label.font = UIFont(name: "Montserrat-Medium", size: 12.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var fileCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15.0)
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
        self.output?.adminCommercialOfferApplicationDidLoad(view: self)

        fileCollectionView.register(SupplierCommercialOfferViewAlphaFileCell.self, forCellWithReuseIdentifier: SupplierCommercialOfferViewAlphaFileCell.reuseIdentifier)
        fileCollectionView.delegate = self
        fileCollectionView.dataSource = self

        self.layout()
        self.setup()

        #if SWIFT_PACKAGE
        cancelButton.setImage(UIImage(named: "X", in: Bundle.module, compatibleWith: nil), for: .normal)
        #else
        cancelButton.setImage(UIImage(named: "X", in: Bundle(for: Self.self), compatibleWith: nil), for: .normal)
        #endif
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.rejectCommercialOffer.layer.borderWidth = 1
        self.rejectCommercialOffer.layer.borderColor = UIColor.black.cgColor
        self.commercialOfferImageView.layer.masksToBounds = true
    }
}

// MARK: - Actions
extension AdminCommercialOfferApplicationViewAlpha {
    @objc
    private func cancelTouchUpInside(_ sender: Any) {
        dismiss(animated: true)
    }

    @objc
    private func approveCommercialOfferButtonTouchUpInside(_ sender: Any) {
        output?.adminCommercialOfferApplication(view: self, userWantsToApprove: sender)
    }

    @objc
    private func rejectCommercialOfferButtonTouchUpInside(_ sender: Any) {
        output?.adminCommercialOfferApplication(view: self, userWantsToReject: sender)
    }
}

// MARK: - Setup
extension AdminCommercialOfferApplicationViewAlpha {
    private func setup() {
        cancelButton.addTarget(self, action: #selector(AdminCommercialOfferApplicationViewAlpha.cancelTouchUpInside(_:)), for: .touchUpInside)
        approveCommercialOffer.addTarget(self, action: #selector(AdminCommercialOfferApplicationViewAlpha.approveCommercialOfferButtonTouchUpInside(_:)), for: .touchUpInside)
        rejectCommercialOffer.addTarget(self, action: #selector(AdminCommercialOfferApplicationViewAlpha.rejectCommercialOfferButtonTouchUpInside(_:)), for: .touchUpInside)
    }
}

extension AdminCommercialOfferApplicationViewAlpha: AdminCommercialOfferApplicationViewInput {
    func showAttachment(fileUrl: URL) {
        self.attachmentFileUrl = fileUrl
        let quickLookViewController = QLPreviewController()
        quickLookViewController.dataSource = self
        self.present(quickLookViewController, animated: true)
    }
}

// MARK: - QLPreviewControllerDataSource
extension AdminCommercialOfferApplicationViewAlpha: QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return self.attachmentFileUrl == nil ? 0 : 1
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        guard let fileUrl = self.attachmentFileUrl else {
            fatalError()
        }
        return fileUrl as NSURL
    }
}

// MARK: - UICollectionViewDelegate
extension AdminCommercialOfferApplicationViewAlpha: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.output?.adminCommercialOfferApplication(view: self, didTapOnAttachmentAtIndex: indexPath.row)
    }
}

// MARK: - UICollectionViewDataSource
extension AdminCommercialOfferApplicationViewAlpha: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.attachmentNames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SupplierCommercialOfferViewAlphaFileCell.reuseIdentifier, for: indexPath) as! SupplierCommercialOfferViewAlphaFileCell

        cell.fileNameLabel.text = self.attachmentNames[indexPath.row]

        return cell
    }
}

// MARK: - Layout
extension AdminCommercialOfferApplicationViewAlpha {
    private func layout() {
        layoutCommercialOfferImageView(in: self.view)
        layoutCancelButton(in: self.view)
        layoutOrganizationNameLabel(in: self.view)
        layoutCommercialOfferCreatedDateLabel(in: self.view)
        layoutCommercialOfferMessageLabel(in: self.view)
        layoutCollectionView(in: self.view)
        layoutApproveCommercialOffer(in: self.view)
        layoutRejectCommercialOfferButton(in: self.view)
    }

    private func layoutCommercialOfferImageView(in container: UIView) {
        let imageView = commercialOfferImageView
        container.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(greaterThanOrEqualTo: self.commercialOfferImageView.widthAnchor, multiplier: 89/207)
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
            label.topAnchor.constraint(equalTo: self.commercialOfferImageView.bottomAnchor, constant: 20.0)
        ])
    }

    private func layoutCommercialOfferCreatedDateLabel(in container: UIView) {
        let label = commercialOfferCreatedDateLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            label.topAnchor.constraint(equalTo: self.commercialOfferImageView.bottomAnchor, constant: 26.0)
        ])
    }

    private func layoutCommercialOfferMessageLabel(in container: UIView) {
        let label = commercialOfferMessageLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.organizationNameLabel.leftAnchor),
            label.rightAnchor.constraint(equalTo: self.commercialOfferCreatedDateLabel.rightAnchor),
            label.topAnchor.constraint(equalTo: self.organizationNameLabel.bottomAnchor, constant: 10.0),
            label.heightAnchor.constraint(lessThanOrEqualToConstant: 100.0)
        ])
    }

    private func layoutCollectionView(in container: UIView) {
        let collectionView = fileCollectionView
        container.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            collectionView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            collectionView.topAnchor.constraint(equalTo: self.commercialOfferMessageLabel.bottomAnchor, constant: 8.0),
            collectionView.heightAnchor.constraint(equalToConstant: 70.0)
        ])
    }

    private func layoutApproveCommercialOffer(in container: UIView) {
        let button = approveCommercialOffer
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.leftAnchor.constraint(equalTo: self.organizationNameLabel.leftAnchor),
            button.rightAnchor.constraint(equalTo: self.commercialOfferCreatedDateLabel.rightAnchor),
            button.topAnchor.constraint(equalTo: self.fileCollectionView.bottomAnchor, constant: 10.0),
            button.heightAnchor.constraint(equalToConstant: 52.0)
        ])
    }

    private func layoutRejectCommercialOfferButton(in container: UIView) {
        let button = rejectCommercialOffer
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.leftAnchor.constraint(equalTo: self.organizationNameLabel.leftAnchor),
            button.rightAnchor.constraint(equalTo: self.commercialOfferCreatedDateLabel.rightAnchor),
            button.topAnchor.constraint(equalTo: self.approveCommercialOffer.bottomAnchor, constant: 15.0),
            button.heightAnchor.constraint(equalToConstant: 52.0),
            button.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor, constant: -20.0)
        ])
    }
}
