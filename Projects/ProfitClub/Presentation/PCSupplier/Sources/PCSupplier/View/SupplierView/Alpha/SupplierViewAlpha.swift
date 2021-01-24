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

final class SupplierViewAlpha: UIViewController {
    var output: SupplierViewOutput?

    private lazy var createCommercialOfferButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Создать коммерческое предложение", for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15.0)
        button.setTitleColor(#colorLiteral(red: 0.9450980392, green: 0.9058823529, blue: 0.8941176471, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(SupplierViewAlpha.createCommercialOfferTouchUpInside(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var createActionButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Создать акцию", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.09803921569, green: 0.09411764706, blue: 0.09411764706, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15.0)
        button.addTarget(self, action: #selector(SupplierViewAlpha.createActionTouchUpInside(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = .black
    }

    private func setup() {
        self.view.backgroundColor = .white

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "barItem"), style: .plain, target: self, action: #selector(SupplierViewAlpha.menuBarButtonItemAction(_:)))

        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Profit Club"
        label.font = UIFont(name: "PlayfairDisplay-Bold", size: 25)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }

    @objc private func createCommercialOfferTouchUpInside(_ sender: Any) {
        self.output?.supplier(view: self, wantsToCreateCommercialOffer: sender)
    }

    @objc private func createActionTouchUpInside(_ sender: Any) {
        self.output?.supplierView(view: self, supplierWantsToCreateAction: sender)
    }

    @objc private func menuBarButtonItemAction(_ sender: Any) {
        self.output?.supplier(view: self, tappenOn: sender)
    }
}

// MARK: - Layout
extension SupplierViewAlpha {
    private func layout() {
        layoutCreateCommercialOfferButton(in: self.view)
        layoutCreateActionButton(in: self.view)
    }

    private func layoutCreateCommercialOfferButton(in container: UIView) {
        let button = createCommercialOfferButton
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            button.heightAnchor.constraint(equalToConstant: 52.0)
        ])
    }

    private func layoutCreateActionButton(in container: UIView) {
        let button = createActionButton
        container.addSubview(button)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.0),
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.0),
            button.topAnchor.constraint(equalTo: self.createCommercialOfferButton.bottomAnchor, constant: 15.0),
            button.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor, constant: -20.0),
            button.heightAnchor.constraint(equalToConstant: 52.0)
        ])
    }
}

extension SupplierViewAlpha: SupplierViewInput {
}
