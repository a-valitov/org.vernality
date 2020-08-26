//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/26/20
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
import ProfitClubModel

extension SelectRoleViewAlpha: SelectRoleViewInput {
}

final class SelectRoleViewAlpha: UIViewController {
    var output: SelectRoleViewOutput?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.layout()
        self.localize()
        self.style()
    }

    @objc
    private func memberButtonTouchUpInside(_ sender: Any) {
        self.output?.selectRole(view: self, didSelect: .member)
    }

    @objc
    private func organizationButtonTouchUpInside(_ sender: Any) {
        self.output?.selectRole(view: self, didSelect: .organization)
    }

    @objc
    private func supplierButtonTouchUpInside(_ sender: Any) {
        self.output?.selectRole(view: self, didSelect: .supplier)
    }

    private func setup() {
        self.memberButton.addTarget(self, action: #selector(SelectRoleViewAlpha.memberButtonTouchUpInside(_:)), for: .touchUpInside)
        self.organizationButton.addTarget(self, action: #selector(SelectRoleViewAlpha.organizationButtonTouchUpInside(_:)), for: .touchUpInside)
        self.supplierButton.addTarget(self, action: #selector(SelectRoleViewAlpha.supplierButtonTouchUpInside(_:)), for: .touchUpInside)
    }

    private func localize() {
        self.memberButton.setTitle("Member", for: .normal)
        self.organizationButton.setTitle("Organization", for: .normal)
        self.supplierButton.setTitle("Supplier", for: .normal)
    }

    private func style() {
        self.view.backgroundColor = .white
        self.memberButton.setTitleColor(.blue, for: .normal)
        self.organizationButton.setTitleColor(.blue, for: .normal)
        self.supplierButton.setTitleColor(.blue, for: .normal)
    }

    private let stackView = UIStackView()
    private let memberButton = UIButton()
    private let organizationButton = UIButton()
    private let supplierButton = UIButton()
}

// MARK: - Layout
extension SelectRoleViewAlpha {
    private func layout() {
        self.layoutStack(in: self.view)
        self.layoutMember(in: self.stackView)
        self.layoutOrganization(in: self.stackView)
        self.layoutSupplier(in: self.stackView)
    }

    private func layoutStack(in container: UIView) {
        let stack = self.stackView
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 16
        self.view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            container.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 20)
        ])
    }

    private func layoutMember(in stack: UIStackView) {
        let member = self.memberButton
        member.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(member)
    }

    private func layoutOrganization(in stack: UIStackView) {
        let organization = self.organizationButton
        organization.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(organization)
    }

    private func layoutSupplier(in stack: UIStackView) {
        let supplier = self.supplierButton
        supplier.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(supplier)
    }
}
