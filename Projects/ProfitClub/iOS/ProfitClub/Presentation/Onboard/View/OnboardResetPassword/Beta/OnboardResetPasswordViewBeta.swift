//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 14.11.2020
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

final class OnboardResetPasswordViewBeta: UIViewController {
    var output: OnboardResetPasswordViewOutput?

    var email: String? {
        if self.isViewLoaded {
            return self.emailTextField.text
        } else {
            return nil
        }
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resetPasswordButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        let textColor = UIColor(red: 0.953, green: 0.918, blue: 0.906, alpha: 1)
        let placeholderColor = textColor.withAlphaComponent(0.5)
        self.emailTextField.attributedPlaceholder = NSAttributedString(string: "Электронная почта",
                                                                       attributes:[.foregroundColor: placeholderColor])

        self.emailTextField.tintColor = textColor

        navigationItem.title = "Сбросить пароль"

        emailTextField.delegate = self

        errorLabel.isHidden = true

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func resetButtonTouchUpInside(_ sender: Any) {
        self.output?.onboardResetPasswordDidFinish(view: self)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        self.resetPasswordButton.frame.origin.y = self.resetPasswordButton.frame.origin.y - keyboardSize.height
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.resetPasswordButton.frame.origin.y = 0
    }
}

extension OnboardResetPasswordViewBeta: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension OnboardResetPasswordViewBeta: OnboardResetPasswordViewInput {
    func alert() {
        let alertController = UIAlertController(title: "Invalid Email", message: "Please check your email", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Хорошо", style: .default)

        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
