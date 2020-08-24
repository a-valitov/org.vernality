//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/23/20
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

protocol ConnectTelegramIntroViewControllerDelegate: class {
    func connectTelegramIntro(_ viewController: ConnectTelegramIntroViewController, userWantsToContinue sender: Any)
}

final class ConnectTelegramIntroViewController: UIViewController {
    weak var delegate: ConnectTelegramIntroViewControllerDelegate?

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
    private func continueButtonTouchUpInside(_ sender: Any) {
        self.delegate?.connectTelegramIntro(self, userWantsToContinue: sender)
    }

    private func setup() {
        self.continueButton.addTarget(self, action: #selector(ConnectTelegramIntroViewController.continueButtonTouchUpInside(_:)), for: .touchUpInside)
    }

    private func layout() {
        self.layoutContinue(in: self.view)
    }

    private func layoutContinue(in container: UIView) {
        let continueButton = self.continueButton
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(continueButton)

        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 20),
            continueButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            container.safeAreaLayoutGuide.bottomAnchor.constraint(greaterThanOrEqualTo: continueButton.bottomAnchor, constant: 20),
        ])
    }

    private func localize() {
        self.continueButton.setTitle("Continue", for: .normal)
    }

    private func style() {
        self.view.backgroundColor = .white
        self.continueButton.setTitleColor(.red, for: .normal)
    }

    private let continueButton = UIButton()
}
