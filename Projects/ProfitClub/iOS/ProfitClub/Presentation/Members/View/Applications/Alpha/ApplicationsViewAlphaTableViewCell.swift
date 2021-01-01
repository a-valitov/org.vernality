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

protocol ApplicationsViewAlphaTableViewCellDelegate: class {
    func applicationsViewAlpha(cell: ApplicationsViewAlphaTableViewCell, didAskToApprove sender: Any)
    func applicationsViewAlpha(cell: ApplicationsViewAlphaTableViewCell, didAskToReject sender: Any)
}

final class ApplicationsViewAlphaTableViewCell: UITableViewCell {
    weak var delegate: ApplicationsViewAlphaTableViewCellDelegate?
    static let reuseIdentifier = "ApplicationsViewAlphaTableViewCellReuseIdentifier"

    lazy var memberImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "🧑 Persona")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var memberNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Елена Коновалова"
        label.font = UIFont(name: "Montserrat-Medium", size: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var applicationDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 10.0)
        label.textColor = #colorLiteral(red: 0.4588235294, green: 0.4549019608, blue: 0.4549019608, alpha: 1)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        label.text = dateFormatter.string(from: Date())
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var approveMemberButton: UIButton = {
        let button = UIButton()
        button.setTitle("Одобрить", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.9372549057, green: 0.5125920588, blue: 0.03754611422, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 15.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var rejectMemberButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отклонить", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 15.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layout()
        self.setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        memberImageView.layer.cornerRadius = memberImageView.frame.height / 2
        memberImageView.clipsToBounds = true
    }
}

// MARK: - Actions
extension ApplicationsViewAlphaTableViewCell {
    @objc
    private func approveMemberButtonTouchUpInside(_ sender: Any) {
        delegate?.applicationsViewAlpha(cell: self, didAskToApprove: sender)
    }

    @objc
    private func rejectMemberButtonTouchUpInside(_ sender: Any) {
        delegate?.applicationsViewAlpha(cell: self, didAskToReject: sender)
    }
}

// MARK: - Setup
extension ApplicationsViewAlphaTableViewCell {
    private func setup() {
        approveMemberButton.addTarget(self, action: #selector(approveMemberButtonTouchUpInside(_:)), for: .touchUpInside)
        rejectMemberButton.addTarget(self, action: #selector(rejectMemberButtonTouchUpInside(_:)), for: .touchUpInside)
    }
}

// MARK: - Layout
extension ApplicationsViewAlphaTableViewCell {
    private func layout() {
        layoutMemberImageView(in: self.contentView)
        layoutMemberNameLabel(in: self.contentView)
        layoutApplicationDateLabel(in: self.contentView)
        layoutStackView(in: self.contentView)
        self.stackView.addArrangedSubview(self.approveMemberButton)
        self.stackView.addArrangedSubview(self.rejectMemberButton)
    }

    private func layoutMemberImageView(in container: UIView) {
        let imageView = memberImageView
        container.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            imageView.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            imageView.heightAnchor.constraint(equalToConstant: 60.0),
            imageView.widthAnchor.constraint(equalToConstant: 60.0)
        ])
    }

    private func layoutMemberNameLabel(in container: UIView) {
        let label = memberNameLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.memberImageView.trailingAnchor, constant: 15.0),
            label.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 20.0)
        ])
    }

    private func layoutApplicationDateLabel(in container: UIView) {
        let label = applicationDateLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.memberNameLabel.leftAnchor),
            label.rightAnchor.constraint(equalTo: self.memberNameLabel.rightAnchor),
            label.topAnchor.constraint(equalTo: memberNameLabel.bottomAnchor, constant: 8.0)
        ])
    }

    private func layoutStackView(in container: UIView) {
        let stack = stackView
        container.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.memberImageView.bottomAnchor, constant: 8.0),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            stack.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor, constant: -4.0)
        ])
    }
}
