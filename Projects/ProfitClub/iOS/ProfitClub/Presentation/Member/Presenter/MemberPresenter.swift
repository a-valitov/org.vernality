//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 08.11.2020
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
import ActivityPresenter
import ProfitClubModel

final class MemberPresenter: MemberModule {
    weak var output: MemberModuleOutput?
    var router: MemberRouter?

    init(presenters: MemberPresenters,
         services: MemberServices) {
        self.presenters = presenters
        self.services = services
    }

    func open(in main: MainModule?) {
        self.router?.main = main
        self.router?.openMemberCurrentActions(output: self)
    }

    // dependencies
    private let presenters: MemberPresenters
    private let services: MemberServices
}

extension MemberPresenter: MemberCurrentActionsViewOutput {
    func memberCurrentActionsDidLoad(view: MemberCurrentActionsViewInput) {
        self.services.action.fetchApproved { [weak self] result in
            switch result {
            case .success(let actions):
                view.actions = actions
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }

    func memberCurrentActions(view: MemberCurrentActionsViewInput, didSelect action: PCAction) {
        self.router?.openMemberCurrentAction(output: self)
    }
}

extension MemberPresenter: MemberCurrentActionViewOutput {
    func memberCurrentActionDidLoad(view: MemberCurrentActionViewInput) {

    }
}
