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

final class AdminCommercialOffersApplicationsViewAlphaCell: UITableViewCell {

    static let reuseIdentifier = "AdminCommercialOffersApplicationsViewAlphaCellReuseIdentifier"

    lazy var commercialOfferImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var supplierNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = UIFont(name: "Montserrat-Medium", size: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var commercialOfferMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.4588235294, green: 0.4549019608, blue: 0.4549019608, alpha: 1)
        label.numberOfLines = .zero
        label.font = UIFont(name: "Montserrat-Regular", size: 15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var commercialOfferCreatedDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 12.0)
        label.textColor = #colorLiteral(red: 0.4588235294, green: 0.4549019608, blue: 0.4549019608, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        commercialOfferImageView.layer.cornerRadius = 10
        commercialOfferImageView.clipsToBounds = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AdminCommercialOffersApplicationsViewAlphaCell {
    private func layout() {
        layoutCommercialOfferImageView(in: self.contentView)
        layoutSupplierNameLabel(in: self.contentView)
        layoutCommercialOfferCreatedDateLabel(in: self.contentView)
        layoutCommercialOfferMessageLabel(in: self.contentView)
    }

    private func layoutCommercialOfferImageView(in container: UIView) {
        let imageView = commercialOfferImageView
        container.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 22.0),
            imageView.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor, constant: 15.0),
            imageView.heightAnchor.constraint(equalToConstant: 55.0),
            imageView.widthAnchor.constraint(equalToConstant: 55.0)
        ])
    }

    private func layoutSupplierNameLabel(in container: UIView) {
        let label = supplierNameLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.commercialOfferImageView.trailingAnchor, constant: 12.0),
            label.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            label.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.475845)
        ])
    }

    private func layoutCommercialOfferCreatedDateLabel(in container: UIView) {
        let label = commercialOfferCreatedDateLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            label.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 4.0),
            label.centerYAnchor.constraint(equalTo: self.supplierNameLabel.centerYAnchor)
        ])
    }

    private func layoutCommercialOfferMessageLabel(in container: UIView) {
        let label = commercialOfferMessageLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.supplierNameLabel.bottomAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: self.commercialOfferImageView.trailingAnchor, constant: 12.0),
            label.trailingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            label.heightAnchor.constraint(equalToConstant: 62.0)
        ])
    }
}

