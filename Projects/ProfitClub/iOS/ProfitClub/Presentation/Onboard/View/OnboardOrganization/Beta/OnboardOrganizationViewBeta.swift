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

extension OnboardOrganizationViewBeta: OnboardOrganizationViewInput {
}

final class OnboardOrganizationViewBeta: UIViewController {
    var output: OnboardOrganizationViewOutput?
    var name: String? {
        if self.isViewLoaded {
            return self.nameTextField.text
        } else {
            return nil
        }
    }
    var inn: String? {
        if self.isViewLoaded {
            return self.innTextField.text
        } else {
            return nil
        }
    }
    var contact: String? {
        if self.isViewLoaded {
            return self.contactTextField.text
        } else {
            return nil
        }
    }
    var phone: String? {
        if self.isViewLoaded {
            return self.phoneTextField.text
        } else {
            return nil
        }
    }

    @IBOutlet weak var policyCheckbox: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var innTextField: UITextField!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!

    @IBAction func submitButtonTouchUpInside(_ sender: Any) {
        self.output?.onboardOrganizationDidFinish(view: self)
    }

    @IBAction func policyCheckboxTouchUpInside(_ sender: UIButton) {
        sender.isSelected.toggle()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        self.innTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        self.contactTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        self.phoneTextField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)

        let textColor = UIColor(red: 0.953, green: 0.918, blue: 0.906, alpha: 1)
        let placeholderColor = textColor.withAlphaComponent(0.5)
        self.nameTextField.attributedPlaceholder = NSAttributedString(string: "Наименование",
                                                                          attributes:[.foregroundColor: placeholderColor])
        self.phoneTextField.attributedPlaceholder = NSAttributedString(string: "Телефон",
                                                                       attributes:[.foregroundColor: placeholderColor])
        self.innTextField.attributedPlaceholder = NSAttributedString(string: "ИНН",
                                                                          attributes:[.foregroundColor: placeholderColor])
        self.contactTextField.attributedPlaceholder = NSAttributedString(string: "ФИО",
                                                                                      attributes:[.foregroundColor: placeholderColor])
        self.nameTextField.tintColor = textColor
        self.phoneTextField.tintColor = textColor
        self.innTextField.tintColor = textColor
        self.contactTextField.tintColor = textColor

        self.nameTextField.textColor = textColor
        self.phoneTextField.textColor = textColor
        self.innTextField.textColor = textColor
        self.contactTextField.textColor = textColor

        self.nameTextField.delegate = self
        self.phoneTextField.delegate = self
        self.innTextField.delegate = self
        self.contactTextField.delegate = self
    }
}

extension OnboardOrganizationViewBeta: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
