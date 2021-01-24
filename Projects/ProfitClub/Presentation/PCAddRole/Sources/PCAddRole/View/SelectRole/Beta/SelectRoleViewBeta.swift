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
import PCModel

extension SelectRoleViewBeta: SelectRoleViewInput {
}

final class SelectRoleViewBeta: UIViewController {
    var output: SelectRoleViewOutput?

    @IBOutlet weak var supplierCheckbox: UIButton!
    @IBOutlet weak var organizationCheckbox: UIButton!
    @IBOutlet weak var memberCheckbox: UIButton!
    @IBOutlet var checkboxes: [UIButton]!
    @IBOutlet weak var continueButton: UIButton!


    @IBAction func continueButtonTouchUpInside(_ sender: Any) {
        if let role = self.selectedRole {
            self.output?.selectRole(view: self, didSelect: role)
        }
    } 

    @IBAction func memberButtonTouchUpInside(_ sender: UIButton) {
        self.checkboxes.forEach({ $0.isSelected = false })
        self.memberCheckbox.isSelected.toggle()
        if self.memberCheckbox.isSelected {
            self.selectedRole = .member
        }
    }

    @IBAction func supplierButtonTouchUpInside(_ sender: UIButton) {
        self.checkboxes.forEach({ $0.isSelected = false })
        self.supplierCheckbox.isSelected.toggle()
        if self.supplierCheckbox.isSelected {
            self.selectedRole = .supplier
        }
    }

    @IBAction func organizationButtonTouchUpInside(_ sender: UIButton) {
        self.checkboxes.forEach({ $0.isSelected = false })
        self.organizationCheckbox.isSelected.toggle()
        if self.organizationCheckbox.isSelected {
            self.selectedRole = .organization
        }
    }

    override func viewDidLoad() {
        self.navigationController?.navigationBar.barStyle = .black
    }

    private var selectedRole: PCRole? {
        didSet {
            self.continueButton.isEnabled = self.selectedRole != nil
        }
    }
}
