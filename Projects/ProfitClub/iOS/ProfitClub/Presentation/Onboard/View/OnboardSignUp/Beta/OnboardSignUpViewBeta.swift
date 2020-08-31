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
    
    @IBAction func signUpButtonTouchUpInside(_ sender: Any) {
        self.output?.onboardSignUp(view: self, userWantsToSignUp: sender)
    }
}
