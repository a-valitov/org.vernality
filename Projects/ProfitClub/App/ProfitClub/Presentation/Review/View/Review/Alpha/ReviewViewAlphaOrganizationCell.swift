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

final class ReviewViewAlphaOrganizationCell: UITableViewCell {

    static let reuseIdentifier = "ReviewViewAlphaOrganizationCellReuseIdentifier"

    lazy var organizationNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Bold", size: 20.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var organizationINN: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 16.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 0.6995130565)
        label.text = "ИНН:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var organizationINNLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 18.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var organizationContact: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 16.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 0.6995130565)
        label.text = "Контактное лицо:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var organizationContactLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 18.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()

    private lazy var organizationPhoneNumber: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 16.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 0.6995130565)
        label.text = "Телефон:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var organizationPhoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 18.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var organizationStatusLabel: UILabel = {
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
extension ReviewViewAlphaOrganizationCell {
    private func layout() {
        layoutOrganizationNameLabel(in: self.contentView)
        layoutOrganizationINN(in: self.contentView)
        layoutOrganizationINNLabel(in: self.contentView)
        layoutOrganizationContact(in: self.contentView)
        layoutOrganizationContactLabel(in: self.contentView)
        layoutOrganizationPhoneNumber(in: self.contentView)
        layoutOrganizationPhoneNumberLabel(in: self.contentView)
        layoutOrganizationStatusLabel(in: self.contentView)
    }

    private func layoutOrganizationNameLabel(in container: UIView) {
        let label = self.organizationNameLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 11.0),
            label.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            label.trailingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
        ])
    }

    private func layoutOrganizationINN(in container: UIView) {
        let label = self.organizationINN
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            label.topAnchor.constraint(equalTo: self.organizationNameLabel.bottomAnchor, constant: 16.0)
        ])
    }

    private func layoutOrganizationINNLabel(in container: UIView) {
        let label = self.organizationINNLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: self.organizationINN.trailingAnchor, constant: 8.0),
            label.centerYAnchor.constraint(equalTo: self.organizationINN.centerYAnchor)
        ])
    }

    private func layoutOrganizationContact(in container: UIView) {
        let label = self.organizationContact
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0)
        ])
    }

    private func layoutOrganizationContactLabel(in container: UIView) {
        let label = self.organizationContactLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: self.organizationContact.trailingAnchor, constant: 8.0),
            label.centerYAnchor.constraint(equalTo: self.organizationContact.centerYAnchor),
            label.topAnchor.constraint(equalTo: self.organizationINNLabel.bottomAnchor, constant: 8.0)
        ])
    }

    private func layoutOrganizationPhoneNumber(in container: UIView) {
        let label = self.organizationPhoneNumber
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0)
        ])
    }

    private func layoutOrganizationPhoneNumberLabel(in container: UIView) {
        let label = self.organizationPhoneNumberLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: self.organizationPhoneNumber.trailingAnchor, constant: 8.0),
            label.centerYAnchor.constraint(equalTo: self.organizationPhoneNumber.centerYAnchor),
            label.topAnchor.constraint(equalTo: self.organizationContactLabel.bottomAnchor, constant: 8.0)
        ])
    }

    private func layoutOrganizationStatusLabel(in container: UIView) {
        let label = self.organizationStatusLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.organizationPhoneNumberLabel.bottomAnchor, constant: 20.0),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20.0),
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor)
        ])
    }
}
