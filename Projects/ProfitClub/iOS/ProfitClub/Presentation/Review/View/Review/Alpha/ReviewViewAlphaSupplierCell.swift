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

final class ReviewViewAlphaSupplierCell: UITableViewCell {

    static let reuseIdentifier = "ReviewViewAlphaSupplierCellReuseIdentifier"

    lazy var supplierNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Bold", size: 20.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var supplierINN: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 16.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 0.6995130565)
        label.text = "ИНН:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var supplierINNLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 18.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var supplierContact: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 16.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 0.6995130565)
        label.text = "Контактное лицо:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var supplierContactLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 18.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var supplierPhoneNumber: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 16.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 0.6995130565)
        label.text = "Телефон:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var supplierPhoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 18.0)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var supplierStatusLabel: UILabel = {
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
extension ReviewViewAlphaSupplierCell {
    private func layout() {
        layoutSupplierNameLabel(in: self.contentView)
        layoutSupplierINN(in: self.contentView)
        layoutSupplierINNLabel(in: self.contentView)
        layoutSupplierContact(in: self.contentView)
        layoutSupplierContactLabel(in: self.contentView)
        layoutSupplierPhoneNumber(in: self.contentView)
        layoutSupplierPhoneNumberLabel(in: self.contentView)
        layoutSupplierStatusLabel(in: self.contentView)
    }

    private func layoutSupplierNameLabel(in container: UIView) {
        let label = self.supplierNameLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 11.0),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
        ])
    }

    private func layoutSupplierINN(in container: UIView) {
        let label = self.supplierINN
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            label.topAnchor.constraint(equalTo: self.supplierNameLabel.bottomAnchor, constant: 16.0)
        ])
    }

    private func layoutSupplierINNLabel(in container: UIView) {
        let label = self.supplierINNLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            label.leadingAnchor.constraint(lessThanOrEqualTo: self.supplierINN.trailingAnchor, constant: 8.0),
            label.centerYAnchor.constraint(equalTo: self.supplierINN.centerYAnchor)
        ])
    }

    private func layoutSupplierContact(in container: UIView) {
        let label = self.supplierContact
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0)
        ])
    }

    private func layoutSupplierContactLabel(in container: UIView) {
        let label = self.supplierContactLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            label.leadingAnchor.constraint(lessThanOrEqualTo: self.supplierContact.trailingAnchor, constant: 8.0),
            label.centerYAnchor.constraint(equalTo: self.supplierContact.centerYAnchor),
            label.topAnchor.constraint(equalTo: self.supplierINNLabel.bottomAnchor, constant: 8.0)
        ])
    }

    private func layoutSupplierPhoneNumber(in container: UIView) {
        let label = self.supplierPhoneNumber
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0)
        ])
    }

    private func layoutSupplierPhoneNumberLabel(in container: UIView) {
        let label = self.supplierPhoneNumberLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            label.leadingAnchor.constraint(lessThanOrEqualTo: self.supplierPhoneNumber.trailingAnchor, constant: 8.0),
            label.centerYAnchor.constraint(equalTo: self.supplierPhoneNumber.centerYAnchor),
            label.topAnchor.constraint(equalTo: self.supplierContactLabel.bottomAnchor, constant: 8.0)
        ])
    }

    private func layoutSupplierStatusLabel(in container: UIView) {
        let label = self.supplierStatusLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.supplierPhoneNumberLabel.bottomAnchor, constant: 20.0),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20.0),
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor)
        ])
    }
}
