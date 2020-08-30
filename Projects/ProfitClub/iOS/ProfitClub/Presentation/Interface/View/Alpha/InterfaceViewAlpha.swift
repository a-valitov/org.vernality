//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/27/20
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

final class InterfaceViewAlpha: UIViewController {
    var output: InterfaceViewOutput?
    var member: PCMember? {
        didSet {
            self.reconstruct()
        }
    }
    var organizations: [PCOrganization]? {
        didSet {
            self.reconstruct()
        }
    }
    var suppliers: [PCSupplier]? {
        didSet {
            self.reconstruct()
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.reconstruct()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private var stackView = UIStackView()
    private var memberButton: UIButton?
    private var organizationButtons = [UIButton]()
    private var supplierButtons = [UIButton]()

    private func reconstruct() {
        self.setup()
        self.layout()
        self.localize()
        self.style()
    }

    private func setup() {

    }

    private func layout() {
        self.view.subviews.forEach({ $0.removeFromSuperview() })
        self.memberButton = nil
        self.organizationButtons.removeAll()
        self.supplierButtons.removeAll()

        self.stackView = self.layoutStack(in: self.view)
        self.layoutMember(in: self.stackView)
        self.layoutOrganizations(in: self.stackView)
        self.layoutSuppliers(in: self.stackView)
    }

    private func layoutMember(in stack: UIStackView) {
        if let member = self.member {
            let memberButton = UIButton()
            memberButton.setTitle(member.firstName, for: .normal)
            memberButton.addTarget(self, action: #selector(InterfaceViewAlpha.memberButtonTouchUpInside(_:)), for: .touchUpInside)
            memberButton.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview(memberButton)
            self.memberButton = memberButton
        }
    }

    private func layoutOrganizations(in stack: UIStackView) {
        if let organizations = self.organizations {
            for org in organizations {
                let orgButton = UIButton()
                orgButton.setTitle(org.name, for: .normal)
                orgButton.translatesAutoresizingMaskIntoConstraints = false
                stack.addArrangedSubview(orgButton)
                self.organizationButtons.append(orgButton)
            }
        }
    }

    private func layoutSuppliers(in stack: UIStackView) {
        if let suppliers = self.suppliers {
            for sup in suppliers {
                let supButton = UIButton()
                supButton.setTitle(sup.name, for: .normal)
                supButton.translatesAutoresizingMaskIntoConstraints = false
                stack.addArrangedSubview(supButton)
                self.supplierButtons.append(supButton)
            }
        }
    }

    private func layoutStack(in container: UIView) -> UIStackView {
        let stack = UIStackView()
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
        return stack
    }

    private func localize() {

    }

    private func style() {
        self.view.backgroundColor = .white
        self.memberButton?.setTitleColor(.red, for: .normal)
        self.organizationButtons.forEach({ $0.setTitleColor(.blue, for: .normal) })
        self.supplierButtons.forEach({ $0.setTitleColor(.orange, for: .normal) })
    }
}

// MARK: - IBActions
extension InterfaceViewAlpha {
    @objc
    private func memberButtonTouchUpInside(_ sender: Any) {

    }
}
