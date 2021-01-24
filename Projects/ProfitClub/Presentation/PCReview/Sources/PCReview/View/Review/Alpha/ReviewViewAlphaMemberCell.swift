//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 26.11.2020
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

final class ReviewViewAlphaMemberCell: UITableViewCell {

    static let reuseIdentifier = "ReviewViewAlphaMemberCellReuseIdentifier"

    lazy var memberFullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Bold", size: 20.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var memberStatusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-SemiBold", size: 16.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension ReviewViewAlphaMemberCell {
    private func layout() {
        layoutMemberFullnameLabel(in: self.contentView)
        layoutMemberStatusLabel(in: self.contentView)
    }

    private func layoutMemberFullnameLabel(in container: UIView) {
        let label = self.memberFullnameLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 11.0),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
        ])
    }

    private func layoutMemberStatusLabel(in container: UIView) {
        let label = self.memberStatusLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.memberFullnameLabel.bottomAnchor, constant: 20.0),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20.0),
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor)
        ])
    }
}

