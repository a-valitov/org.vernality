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

final class SupplierCommercialOfferViewAlphaFileCell: UICollectionViewCell {

    static let reuseIdentifier = "FileCellReuseIdentifier"

    lazy var fileNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Light", size: 9.0)
        label.textColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var fileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        #if SWIFT_PACKAGE
        fileImageView.image = UIImage(named: "pdf", in: Bundle.module, compatibleWith: nil)
        #else
        fileImageView.image = UIImage(named: "pdf", in: Bundle(for: Self.self), compatibleWith: nil)
        #endif
        layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension SupplierCommercialOfferViewAlphaFileCell {
    private func layout() {
        layoutFileImageView(in: self.contentView)
        layoutFileNameLabel(in: self.contentView)
    }

    private func layoutFileImageView(in container: UIView) {
        let imageView = fileImageView
        container.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0)
        ])
    }

    private func layoutFileNameLabel(in container: UIView) {
        let label = fileNameLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.fileImageView.bottomAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0)
        ])
    }
}
