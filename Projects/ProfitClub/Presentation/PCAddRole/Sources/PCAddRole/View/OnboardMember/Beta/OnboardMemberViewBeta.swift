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
    var image: UIImage? {
        if self.isViewLoaded {
            #if SWIFT_PACKAGE
            return UIImage(named: "profileImage", in: Bundle.module, compatibleWith: nil)
            #else
             return UIImage(named: "profileImage", in: Bundle(for: Self.self), compatibleWith: nil)
            #endif
        } else {
            return nil
        }
    }

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!


    @IBAction func submitButtonTouchUpInside(_ sender: Any) {
        self.output?.onboardMemberDidFinish(view: self)
    }

    @IBAction func policyCheckboxTouchUpInside(_ sender: UIButton) {
        sender.isSelected.toggle()
        self.firstNameTextField.resignFirstResponder()
        self.lastNameTextField.resignFirstResponder()
    }

     override func viewDidLoad() {
        super.viewDidLoad()
        self.firstNameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        self.lastNameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)

        let textColor = UIColor(red: 0.953, green: 0.918, blue: 0.906, alpha: 1)
        let placeholderColor = textColor.withAlphaComponent(0.5)
        self.firstNameTextField.attributedPlaceholder = NSAttributedString(string: "Имя",
                                                                          attributes:[.foregroundColor: placeholderColor])
        self.lastNameTextField.attributedPlaceholder = NSAttributedString(string: "Фамилия",
                                                                          attributes:[.foregroundColor: placeholderColor])

        self.firstNameTextField.tintColor = textColor

        self.lastNameTextField.tintColor = textColor

        self.firstNameTextField.textColor = textColor
        self.lastNameTextField.textColor = textColor

        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
    }
}

extension OnboardMemberViewBeta: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
