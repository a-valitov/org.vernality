//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 21.10.2020
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

extension SupplierActionsBeta: SupplierActionsInput {

}

final class SupplierActionsBeta: UIViewController {
    var output: SupplierActionsOutput?
    var message: String? {
        if self.isViewLoaded {
            return self.messageTextField.text
        } else {
            return nil
        }
    }
    var descriptionOf: String? {
        if self.isViewLoaded {
            return self.descriptionTextField.text
        } else {
            return nil
        }
    }
    var link: String? {
        if self.isViewLoaded {
            return self.linkTextField.text
        } else {
            return nil
        }
    }
    
    var activeTextField : UITextField? = nil

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!

    @IBAction func createActionTouchUpInside(_ sender: Any) {
        self.output?.supplierActionsDidFinish(view: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        self.descriptionTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, -30, 0)
        self.linkTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)

        let textColor = UIColor(red: 0.098, green: 0.094, blue: 0.094, alpha: 1)
        let placeholderColor = textColor.withAlphaComponent(0.5)
        self.messageTextField.attributedPlaceholder = NSAttributedString(string: "Введите сообщение",
                                                                         attributes:[.foregroundColor: placeholderColor])
        self.descriptionTextField.attributedPlaceholder = NSAttributedString(string: "Введите описание акции",
                                                                             attributes:[.foregroundColor: placeholderColor])
        self.linkTextField.attributedPlaceholder = NSAttributedString(string: "Вставьте ссылку на акцию",
                                                                      attributes:[.foregroundColor: placeholderColor])

        self.messageTextField.delegate = self
        self.descriptionTextField.delegate = self
        self.linkTextField.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {

        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

        var shouldMoveViewUp = false

        if let activeTextField = activeTextField {
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
            let topOfKeyboard = self.view.frame.height - keyboardSize.height

            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }

        if (shouldMoveViewUp) {
            self.view.frame.origin.y = 0 - keyboardSize.height
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
}

extension SupplierActionsBeta: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
}
