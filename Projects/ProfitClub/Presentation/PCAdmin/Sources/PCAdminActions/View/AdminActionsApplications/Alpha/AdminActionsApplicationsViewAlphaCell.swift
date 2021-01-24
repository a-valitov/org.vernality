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

final class AdminActionsApplicationsViewAlphaCell: UITableViewCell {

    static let reuseIdentifier = "AdminActionsApplicationsViewAlphaCell"

    lazy var actionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var actionMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Montserrat-Medium", size: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var actionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = #colorLiteral(red: 0.4588235294, green: 0.4549019608, blue: 0.4549019608, alpha: 1)
        label.font = UIFont(name: "Montserrat-Regular", size: 15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var actionLinkLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 12.0)
        label.textColor = #colorLiteral(red: 0.4588235294, green: 0.4549019608, blue: 0.4549019608, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var actionEndDate: UILabel = {
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

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        actionImageView.layer.cornerRadius = actionImageView.frame.height / 2
        actionImageView.clipsToBounds = true
    }
}

// MARK: - Layout
extension AdminActionsApplicationsViewAlphaCell {
    private func layout() {
        layoutActionImageView(in: self.contentView)
        layoutActionMessage(in: self.contentView)
        layoutActionEndDate(in: self.contentView)
        layoutActionDescription(in: self.contentView)
        layoutActionLink(in: self.contentView)
    }

    private func layoutActionImageView(in container: UIView) {
        let imageView = actionImageView
        container.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 23.0),
            imageView.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            imageView.heightAnchor.constraint(equalToConstant: 45.0),
            imageView.widthAnchor.constraint(equalToConstant: 45.0)
        ])
    }

    private func layoutActionMessage(in container: UIView) {
        let label = actionMessageLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.actionImageView.trailingAnchor, constant: 12.0),
            label.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            label.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.46875)
        ])
    }

    private func layoutActionEndDate(in container: UIView) {
        let label = actionEndDate
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            label.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 4.0),
            label.centerYAnchor.constraint(equalTo: self.actionMessageLabel.centerYAnchor)
        ])
    }

    private func layoutActionDescription(in container: UIView) {
        let label = actionDescriptionLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.actionMessageLabel.bottomAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: self.actionImageView.trailingAnchor, constant: 12.0),
            label.trailingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            label.heightAnchor.constraint(equalToConstant: 40.0)
        ])
    }

    private func layoutActionLink(in container: UIView) {
        let label = actionLinkLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            label.topAnchor.constraint(equalTo: self.actionDescriptionLabel.bottomAnchor, constant: 0),
            label.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            label.leftAnchor.constraint(equalTo: self.actionDescriptionLabel.leftAnchor)
        ])
    }
}
