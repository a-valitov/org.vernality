//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Macbook on 08.01.2021
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

import Foundation
import Main
import ErrorPresenter
import ActivityPresenter
import ConfirmationPresenter
import ProfitClubModel

final class AdminActionPresenter: AdminActionModule {
    weak var output: AdminActionModuleOutput?
    var router: AdminActionRouter?

    init(action: PCAction,
         presenters: AdminActionPresenters,
         services: AdminActionServices) {
        self.action = action
        self.presenters = presenters
        self.services = services
    }

    func open(in main: MainModule?) {
        self.router?.main = main
        self.router?.openApplication(output: self)
    }

    private let action: PCAction

    // dependencies
    private let presenters: AdminActionPresenters
    private let services: AdminActionServices
}

extension AdminActionPresenter: AdminActionApplicationViewOutput {
    func adminActionApplicationDidLoad(view: AdminActionApplicationViewInput) {
        view.actionLink = self.action.link
        view.actionMessage = self.action.message
        view.actionEndDate = self.action.endDate
        view.actionStartDate = self.action.startDate
        view.actionImageUrl = self.action.imageUrl
        view.actionDescription = self.action.descriptionOf
        view.supplierName = self.action.supplier?.name
    }

    func adminActionApplication(view: AdminActionApplicationViewInput, userWantsToApprove sender: Any) {
        self.presenters.confirmation.present(title: "Одобрить акцию?", message: "Одобрить акцию от \(view.supplierName ?? "")", actionTitle: "Одобрить", withCancelAction: true) { [weak self] in
            guard let action = self?.action else { return }
            self?.services.action.approve(action: action, result: { [weak self] (result) in
                guard let sSelf = self else { return }
                switch result {
                case .success(let action):
                    sSelf.output?.adminAction(module: sSelf, didApprove: action)
                    sSelf.router?.closeApplication(view)
                case .failure(let error):
                    sSelf.presenters.error.present(error)
                }
            })
        }
    }

    func adminActionApplication(view: AdminActionApplicationViewInput, userWantsToReject sender: Any) {
        self.presenters.confirmation.present(title: "Отклонить акцию?", message: "Отклонить акцию от \(view.supplierName ?? "")", actionTitle: "Отклонить", withCancelAction: true) { [weak self] in
            guard let action = self?.action else { return }
            self?.services.action.reject(action: action, result: { [weak self] (result) in
                guard let sSelf = self else { return }
                switch result {
                case .success(let action):
                    sSelf.output?.adminAction(module: sSelf, didReject: action)
                    sSelf.router?.closeApplication(view)
                case .failure(let error):
                    sSelf.presenters.error.present(error)
                }
            })
        }
    }
}
