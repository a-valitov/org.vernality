//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 18.11.2020
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

final class OnboardWelcomeViewAlpha: UIViewController {
    var output: OnboardWelcomeViewOutput?

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
        localize()
        style()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @objc private func signInButtonTouchUpInside(_ sender: Any) {
        self.output?.onboardWelcome(view: self, userWantsToSignIn: sender)
    }

    @objc private func signUpButtonTouchUpInside(_ sender: Any) {
        self.output?.onboardWelcome(view: self, userWantsToSignUp: sender)
    }

    private func setup() {
        backgroundImage.image = #imageLiteral(resourceName: "onboard-welcome-bg")
        signInButton.addTarget(self, action: #selector(OnboardWelcomeViewAlpha.signInButtonTouchUpInside(_:)), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(OnboardWelcomeViewAlpha.signUpButtonTouchUpInside(_:)), for: .touchUpInside)
    }

    private func localize() {
        signInButton.setTitle("Уже есть аккаунт? Войти", for: .normal)
        signUpButton.setTitle("Создать аккаунт", for: .normal)
    }

    private func style() {
        signUpButton.backgroundColor = #colorLiteral(red: 0.9719339013, green: 0.82216537, blue: 0.6347154379, alpha: 1)
        signUpButton.setTitleColor(#colorLiteral(red: 0.1570591927, green: 0.1517162919, blue: 0.1515991688, alpha: 1), for: .normal)
        signUpButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 15)

        signInButton.backgroundColor = .clear
        signInButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 15)
        let attributesForTitle1: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue,
            NSAttributedString.Key.foregroundColor: UIColor(red: 245/255, green: 200/255, blue: 145/255, alpha: 1)
        ]
        let attributesForTitle2: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 243/255, green: 234/255, blue: 231/255, alpha: 1)
        ]
        let title1 = NSAttributedString(string: "Войти", attributes: attributesForTitle1)
        let title2 = NSAttributedString(string: "Уже есть аккаунт? ", attributes: attributesForTitle2)

        let combination = NSMutableAttributedString()
        combination.append(title2)
        combination.append(title1)
        signInButton.setAttributedTitle(combination, for: .normal)
    }

    private let stackView = UIStackView()
    private let signUpButton = UIButton()
    private let signInButton = UIButton()
    private let backgroundImage = UIImageView()
}

extension OnboardWelcomeViewAlpha {
    private func layout() {
        layoutBackgroundImage(in: self.view)
        layoutSignUpButton(in: self.view)
        layoutSignInButton(in: self.view)
    }

    private func layoutBackgroundImage(in container: UIView) {
        let image = backgroundImage
        image.contentMode = .scaleAspectFill
        self.view.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            image.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0),
            image.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            image.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0)
        ])
    }

    private func layoutSignUpButton(in container: UIView) {
        let button = signUpButton
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 30),
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -30),
            button.heightAnchor.constraint(equalToConstant: 52.0)
        ])
    }

    private func layoutSignInButton(in container: UIView) {
        let button = signInButton
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 30),
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -30),
            button.topAnchor.constraint(equalTo: self.signUpButton.bottomAnchor, constant: 16),
            button.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 30.0)
        ])
    }
}

extension OnboardWelcomeViewAlpha: OnboardWelcomeViewInput {

}
