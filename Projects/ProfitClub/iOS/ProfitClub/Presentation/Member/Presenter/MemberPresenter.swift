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
import ConfirmationPresenter
import MenuPresenter
import ProfitClubModel

final class MemberPresenter: MemberModule {
    weak var output: MemberModuleOutput?
    var router: MemberRouter?

    var member: PCMember

    init(member: PCMember,
         presenters: MemberPresenters,
         services: MemberServices) {
        self.member = member
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
        self.services.action.fetchApprovedCurrentActions { [weak self] result in
            switch result {
            case .success(let actions):
                view.actions = actions
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }

    func memberCurrentActions(view: MemberCurrentActionsViewInput, didSelect action: PCAction) {
        self.router?.openMemberCurrentAction(action: action, output: self)
    }

    func memberCurrentActions(view: MemberCurrentActionsViewInput, tappenOn menuBarButton: Any) {
        let profile = MenuItem(title: "Профиль", image: #imageLiteral(resourceName: "profile")) { [weak self] in
            guard let sSelf = self else { return }
            sSelf.output?.member(module: sSelf, userWantsToOpenProfileOf: sSelf.member, inside: sSelf.router?.main)
        }
        let changeRole = MenuItem(title: "Сменить роль", image: #imageLiteral(resourceName: "refresh")) { [weak self] in
            guard let sSelf = self else { return }
            sSelf.output?.member(module: sSelf, userWantsToChangeRole: sSelf.router?.main)
        }
        let logout = MenuItem(title: "Выйти", image: #imageLiteral(resourceName: "logout")) { [weak self] in
            guard let sSelf = self else { return }
            sSelf.presenters.confirmation.present(title: "Подтвердите выход", message: "Вы уверены что хотите выйти?", actionTitle: "Выйти", withCancelAction: true) { [weak sSelf] in
                guard let ssSelf = sSelf else { return }
                ssSelf.output?.member(module: ssSelf, userWantsToLogoutInside: ssSelf.router?.main)
            }
        }
        self.presenters.menu.present(items: [profile, changeRole, logout])
    }

    func memberCurrentActions(view: MemberCurrentActionsViewInput, userWantsToRefresh sender: Any) {
        self.services.action.fetchApprovedCurrentActions { [weak self] result in
            switch result {
            case .success(let actions):
                view.actions = actions
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }
}

extension MemberPresenter: MemberCurrentActionViewOutput {
    func memberCurrentActionDidLoad(view: MemberCurrentActionViewInput) {
        
    }
}
