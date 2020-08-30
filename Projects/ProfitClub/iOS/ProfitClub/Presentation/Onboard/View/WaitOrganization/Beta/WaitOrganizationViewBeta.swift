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

extension WaitOrganizationViewBeta: WaitOrganizationViewInput {
}

final class WaitOrganizationViewBeta: UIViewController {
    var output: WaitOrganizationViewOutput?

    var name: String? {
        didSet {
            self.updateDescription()
        }
    }
    var inn: String? {
        didSet {
            self.updateDescription()
        }
    }
    var contact: String? {
        didSet {
            self.updateDescription()
        }
    }
    var phone: String? {
        didSet {
            self.updateDescription()
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBAction func refreshStatusButtonTouchUpInside(_ sender: Any) {

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.updateDescription()
    }

    private func updateDescription() {
        if self.isViewLoaded {
            self.descriptionLabel.text = "Вы отправили запрос на вступление в клуб организации \(self.name ?? "") (ИНН \(self.inn ?? "")) с контактным лицом \(self.contact ?? "") (номер телефона \(self.phone ?? "")). Администрация клуба рассмотрит заявку и сообщит о принятом решении."
        }
    }
}
