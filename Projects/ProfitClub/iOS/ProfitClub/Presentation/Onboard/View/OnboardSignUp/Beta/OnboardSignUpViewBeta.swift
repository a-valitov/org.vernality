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

    var username: String? {
        if self.isViewLoaded {
            return self.usernameTextField.text
        } else {
            return nil
        }
    }

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

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        self.passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        self.passwordConfirmationTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        self.emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)

        let placeholderColor = UIColor(red: 0.953, green: 0.918, blue: 0.906, alpha: 1)
        self.usernameTextField.attributedPlaceholder = NSAttributedString(string: "Имя пользователя",
                                                                          attributes:[.foregroundColor: placeholderColor])
        self.emailTextField.attributedPlaceholder = NSAttributedString(string: "Электронная почта",
                                                                       attributes:[.foregroundColor: placeholderColor])
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Пароль",
                                                                          attributes:[.foregroundColor: placeholderColor])
        self.passwordConfirmationTextField.attributedPlaceholder = NSAttributedString(string: "Подтверждение пароля",
                                                                                      attributes:[.foregroundColor: placeholderColor])
        self.usernameTextField.tintColor = placeholderColor
        self.emailTextField.tintColor = placeholderColor
        self.passwordTextField.tintColor = placeholderColor
        self.passwordConfirmationTextField.tintColor = placeholderColor
    }

    @IBAction func signUpButtonTouchUpInside(_ sender: Any) {
        self.output?.onboardSignUp(view: self, userWantsToSignUp: sender)
    }
}
