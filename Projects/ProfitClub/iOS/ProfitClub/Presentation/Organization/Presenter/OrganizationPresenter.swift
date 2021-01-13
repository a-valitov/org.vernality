//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 10/14/20
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
import MenuPresenter
import ProfitClubModel

final class OrganizationPresenter: OrganizationModule {
    weak var output: OrganizationModuleOutput?
    var router: OrganizationRouter?
    var organization: PCOrganization
    
    init(organization: PCOrganization,
         presenters: OrganizationPresenters,
         services: OrganizationServices) {
        self.organization = organization
        self.presenters = presenters
        self.services = services
    }

    func open(in main: MainModule?) {
        self.router?.main = main
        self.router?.openOrganizationTabBar(organization: organization, output: self)
    }

    // dependencies
    private let presenters: OrganizationPresenters
    private let services: OrganizationServices
}

extension OrganizationPresenter: OrganizationTabBarViewOutput {
    func organizationTabBar(view: OrganizationTabBarViewInput, tappenOn menuBarButton: Any) {
        let profile = MenuItem(title: "Профиль", image: #imageLiteral(resourceName: "profile")) { [weak self] in
            guard let sSelf = self else { return }
            sSelf.output?.organization(module: sSelf, userWantsToOpenProfileOf: sSelf.organization, inside: sSelf.router?.main)
        }
        let changeRole = MenuItem(title: "Сменить роль", image: #imageLiteral(resourceName: "refresh")) { [weak self] in
            guard let sSelf = self else { return }
            sSelf.output?.organization(module: sSelf, userWantsToChangeRole: sSelf.router?.main)
        }
        let logout = MenuItem(title: "Выйти", image: #imageLiteral(resourceName: "logout")) { [weak self] in
            guard let sSelf = self else { return }
            sSelf.presenters.confirmation.present(title: "Подтвердите выход", message: "Вы уверены что хотите выйти?", actionTitle: "Выйти", withCancelAction: true) { [weak sSelf] in
                guard let ssSelf = sSelf else { return }
                ssSelf.output?.organization(module: ssSelf, userWantsToLogoutInside: ssSelf.router?.main)
            }
        }
        self.presenters.menu.present(items: [profile, changeRole, logout])
    }
}

extension OrganizationPresenter: ActionsModuleOutput {
    func actions(module: ActionsModule, didSelect action: PCAction) {
        self.router?.open(action: action, output: self)
    }
}

extension OrganizationPresenter: ActionModuleOutput {

}

extension OrganizationPresenter: CommercialOffersModuleOutput {
    func commercialOffers(module: CommercialOffersModule, didSelect commercialOffer: PCCommercialOffer) {
        self.router?.open(commercialOffer: commercialOffer, output: self)
    }
}

extension OrganizationPresenter: CommercialOfferModuleOutput {

}

extension OrganizationPresenter: MembersModuleOutput {

}
