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

extension OnboardSupplierViewAlpha: OnboardSupplierViewInput {

}

final class OnboardSupplierViewAlpha: UIViewController {
    var output: OnboardSupplierViewOutput?

    var name: String? {
        get {
            return self.nameTextField.text
        }
        set {
            self.nameTextField.text = newValue
        }
    }
    var inn: String? {
        get {
            return self.innTextField.text
        }
        set {
            self.innTextField.text = newValue
        }
    }
    var contact: String? {
        get {
            return self.contactTextField.text
        }
        set {
            self.contactTextField.text = newValue
        }
    }
    var phone: String? {
        get {
            return self.phoneTextField.text
        }
        set {
            self.phoneTextField.text = newValue
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
        self.setup()
        self.layout()
        self.localize()
        self.style()
    }

    @objc private func applyButtonTouchUpInside(_ sender: Any) {
        self.output?.onboardSupplier(view: self, didFinish: sender)
    }

    private func setup() {
        self.titleLabel.textAlignment = .center
        self.subtitleLabel.textAlignment = .center
        self.subtitleLabel.numberOfLines = 0
        self.applyButton.addTarget(self, action: #selector(OnboardSupplierViewAlpha.applyButtonTouchUpInside(_:)), for: .touchUpInside)
    }

    private func localize() {
        self.titleLabel.text = "Поставщик"
        self.subtitleLabel.text = "Чтобы стать поставщиком клуба заполните данные о себе"
        self.nameTextField.placeholder = "Наименование"
        self.innTextField.placeholder = "ИНН"
        self.contactTextField.placeholder = "ФИО"
        self.phoneTextField.placeholder = "Телефон"
        self.applyButton.setTitle("Стать участником клуба!", for: .normal)
    }

    private func style() {
        self.view.backgroundColor = .white
        self.applyButton.setTitleColor(.blue, for: .normal)
    }

    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let nameTextField = UITextField()
    private let innTextField = UITextField()
    private let contactTextField = UITextField()
    private let phoneTextField = UITextField()
    private let applyButton = UIButton()
}

// MARK: - Layout
extension OnboardSupplierViewAlpha {
    private func layout() {
        self.layoutStack(in: self.view)
        self.layout(in: self.stackView)
    }

    private func layout(in stack: UIStackView) {
        stack.addArrangedSubview(self.titleLabel)
        stack.addArrangedSubview(self.subtitleLabel)
        stack.addArrangedSubview(self.nameTextField)
        stack.addArrangedSubview(self.innTextField)
        stack.addArrangedSubview(self.contactTextField)
        stack.addArrangedSubview(self.phoneTextField)
        stack.addArrangedSubview(self.applyButton)
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

}
