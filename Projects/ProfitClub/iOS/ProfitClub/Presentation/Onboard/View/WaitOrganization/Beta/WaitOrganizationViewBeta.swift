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
import ProfitClubModel

extension WaitOrganizationViewBeta: WaitOrganizationViewInput {
}

final class WaitOrganizationViewBeta: UIViewController {
    var output: WaitOrganizationViewOutput?
    var organization: PCOrganization? {
        didSet {
            self.update()
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!

    @IBAction func refreshStatusButtonTouchUpInside(_ sender: Any) {
        self.output?.waitOrganization(view: self, userWantsToRefresh: self.organization)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.update()
    }

    private func update() {
        if self.isViewLoaded {
            guard let organization = self.organization else {
                self.descriptionLabel.text = "Ошибка"
                return
            }
            self.descriptionLabel.text = "Вы отправили запрос на вступление в клуб организации \(organization.name ?? "") (ИНН \(organization.inn ?? "")) с контактным лицом \(organization.contact ?? "") (номер телефона \(organization.phone ?? "")). Администрация клуба рассмотрит заявку и сообщит о принятом решении."
            guard let status = organization.status else {
                self.statusLabel.text = "Ошибка"
                return
            }
            switch status {
            case .onReview:
                self.statusLabel.text = "Статус: на рассмотрении"
            case .approved:
                self.statusLabel.text = "Статус: одобрено"
            case .rejected:
                self.statusLabel.text = "Статус: отклонено"
            case .excluded:
                self.statusLabel.text = "Статус: организация исключена"
            }
        }
    }
}
