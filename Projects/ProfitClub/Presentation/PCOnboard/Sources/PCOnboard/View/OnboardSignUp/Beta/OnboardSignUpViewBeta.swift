//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/31/20
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

extension OnboardSignUpViewBeta: OnboardSignUpViewInput {
}

final class OnboardSignUpViewBeta: UIViewController {
    var output: OnboardSignUpViewOutput?

    var password: String? {
        if self.isViewLoaded {
            return self.passwordTextField.text
        } else {
            return nil
        }
    }

    var passwordConfirmation: String? {
        if self.isViewLoaded {
            return self.passwordConfirmationTextField.text
        } else {
            return nil
        }
    }

    var email: String? {
        if self.isViewLoaded {
            return self.emailTextField.text
        } else {
            return nil
        }
    }

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        self.passwordConfirmationTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        self.emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)

        let textColor = UIColor(red: 0.953, green: 0.918, blue: 0.906, alpha: 1)
        let placeholderColor = textColor.withAlphaComponent(0.5)
        self.emailTextField.attributedPlaceholder = NSAttributedString(string: "Электронная почта",
                                                                       attributes:[.foregroundColor: placeholderColor])
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Пароль",
                                                                          attributes:[.foregroundColor: placeholderColor])
        self.passwordConfirmationTextField.attributedPlaceholder = NSAttributedString(string: "Подтверждение пароля",
                                                                                      attributes:[.foregroundColor: placeholderColor])
        self.emailTextField.tintColor = textColor
        self.passwordTextField.tintColor = textColor
        self.passwordConfirmationTextField.tintColor = textColor

        self.emailTextField.textColor = textColor
        self.passwordTextField.textColor = textColor
        self.passwordConfirmationTextField.textColor = textColor

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

    @IBAction func signUpButtonTouchUpInside(_ sender: Any) {
        self.output?.onboardSignUp(view: self, userWantsToSignUp: sender)
    }

    @IBAction func signInButtonTouchUpInside(_ sender: Any) {
        self.output?.onboardSignIn(view: self, userWantsToSignIp: sender)
    }
}
