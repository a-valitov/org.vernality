//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 10.11.2020
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

final class OrganizationApplicationViewBeta: UIViewController {
    var output: OrganizationApplicationViewOutput?
    var organizationName: String? {
        didSet {
            if self.isViewLoaded {
                self.organizationNameLabel.text = self.organizationName
            }
        }
    }
    var organizationContactName: String? {
        didSet {
            if self.isViewLoaded {
                self.organizationContactNameLabel.text = self.organizationContactName
            }
        }
    }
    var organizationINN: String? {
        didSet {
            if self.isViewLoaded {
                self.organizationINNLabel.text = self.organizationINN
            }
        }
    }
    var organizationPhoneNumber: String? {
        didSet {
            if self.isViewLoaded {
                self.organizationPhoneNumberLabel.text = self.organizationPhoneNumber
            }
        }
    }

    @IBOutlet weak var organizationImageView: UIImageView!
    @IBOutlet weak var organizationNameLabel: UILabel!
    @IBOutlet weak var organizationContactNameLabel: UILabel!
    @IBOutlet weak var organizationINNLabel: UILabel!
    @IBOutlet weak var organizationPhoneNumberLabel: UILabel!
    @IBOutlet weak var rejectOrganization: UIButton! {
        didSet {
            self.rejectOrganization.layer.borderWidth = 1
            self.rejectOrganization.layer.borderColor = UIColor.black.cgColor
        }
    }

    @IBAction func cancelButtonTouchUpInside() {
        dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.output?.organizationApplicationDidLoad(view: self)
    }
}

extension OrganizationApplicationViewBeta: OrganizationApplicationViewInput {
    
}
