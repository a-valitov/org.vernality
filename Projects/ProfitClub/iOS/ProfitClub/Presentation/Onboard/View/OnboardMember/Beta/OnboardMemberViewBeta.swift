//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/30/20
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

extension OnboardMemberViewBeta: OnboardMemberViewInput {
}

final class OnboardMemberViewBeta: UIViewController {
    var output: OnboardMemberViewOutput?

    var firstName: String? {
        get {
            if self.isViewLoaded {
                return self.firstNameTextField.text
            } else {
                return nil
            }
        }
    }

    var lastName: String? {
        get {
            if self.isViewLoaded {
                return self.lastNameTextField.text
            } else {
                return nil
            }
        }
    }

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!


    @IBAction func submitButtonTouchUpInside(_ sender: Any) {
        self.output?.onboardMemberDidFinish(view: self)
    }
}
