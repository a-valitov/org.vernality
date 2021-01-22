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

final class AdminApprovedSuppliersViewAlphaCell: UITableViewCell {

    static let reuseIdentifier = "AdminApprovedSuppliersViewAlphaCell"

    lazy var supplierImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var supplierNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "«Газпромнефтебизнесс»"
        label.font = UIFont(name: "Montserrat-Medium", size: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 10.0)
        label.textColor = #colorLiteral(red: 0.4588235294, green: 0.4549019608, blue: 0.4549019608, alpha: 1)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        label.text = dateFormatter.string(from: Date())
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        supplierImageView.layer.cornerRadius = supplierImageView.frame.height / 2
        supplierImageView.clipsToBounds = true
    }
}

extension AdminApprovedSuppliersViewAlphaCell {
    private func layout() {
        layoutSupplierImageView(in: self.contentView)
        layoutSupplierNameLabel(in: self.contentView)
        layoutDateLabel(in: self.contentView)
    }

    private func layoutSupplierImageView(in container: UIView) {
        let imageView = supplierImageView
        container.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            imageView.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            imageView.heightAnchor.constraint(equalToConstant: 54),
            imageView.widthAnchor.constraint(equalToConstant: 54)
        ])
    }

    private func layoutSupplierNameLabel(in container: UIView) {
        let label = supplierNameLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.supplierImageView.trailingAnchor, constant: 15.0),
            label.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 16.0)
        ])
    }

    private func layoutDateLabel(in container: UIView) {
        let label = dateLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.supplierNameLabel.leftAnchor),
            label.rightAnchor.constraint(equalTo: self.supplierNameLabel.rightAnchor),
            label.topAnchor.constraint(equalTo: self.supplierNameLabel.bottomAnchor, constant: 8.0)
        ])
    }
}
