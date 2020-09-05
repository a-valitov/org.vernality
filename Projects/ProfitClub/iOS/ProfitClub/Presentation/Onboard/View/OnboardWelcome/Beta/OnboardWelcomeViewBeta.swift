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

extension OnboardWelcomeViewBeta: OnboardWelcomeViewInput {
}

final class OnboardWelcomeViewBeta: UIViewController {
    var output: OnboardWelcomeViewOutput?

    @IBOutlet weak var signUpButton: UIButton!

    @IBAction func signInButtonTouchUpInside(_ sender: Any) {
        self.output?.onboardWelcome(view: self, userWantsToSignIn: sender)
    }

    @IBAction func signUpButtonTouchUpInside(_ sender: Any) {
        self.output?.onboardWelcome(view: self, userWantsToSignUp: sender)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
