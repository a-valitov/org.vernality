//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 26.10.2020
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
import ProfitClubModel

final class ActionPresenter: ActionModule {
    weak var output: ActionModuleOutput?
    var router: ActionRouter?
    
    init(action: PCAction,
         presenters: ActionPresenters,
         services: ActionServices) {
        self.action = action
        self.presenters = presenters
        self.services = services
    }
    
    func open(in main: MainModule?) {
        self.router?.main = main
        self.router?.openActionView(output: self)
    }

    private let action: PCAction

    // dependencies
    private let presenters: ActionPresenters
    private let services: ActionServices
}

extension ActionPresenter: ApproveCurrentActionViewOutput {
    func approveCurrentActionDidLoad(view: ApproveCurrentActionViewInput) {
        view.actionImageUrl = self.action.imageUrl
        view.actionMessage = self.action.message
        view.actionDescription = self.action.descriptionOf
        view.actionLink = self.action.link
        view.actionStartDate = self.action.startDate
        view.actionEndDate = self.action.endDate
    }
}
