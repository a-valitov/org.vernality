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
    @IBOutlet weak var signInButton: UIButton!
    
    @IBAction func signInButtonTouchUpInside(_ sender: Any) {
        self.output?.onboardWelcome(view: self, userWantsToSignIn: sender)
    }

    @IBAction func signUpButtonTouchUpInside(_ sender: Any) {
        self.output?.onboardWelcome(view: self, userWantsToSignUp: sender)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
