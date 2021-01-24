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
import UIKit
import ErrorPresenter
import ActivityPresenter
import ConfirmationPresenter
import MenuPresenter
import PCModel

final class OrganizationPresenter: OrganizationModule {
    weak var output: OrganizationModuleOutput?
    var organization: PCOrganization
    var viewController: UIViewController {
        return self.tabBar
    }
    
    init(organization: PCOrganization,
         presenters: OrganizationPresenters,
         services: OrganizationServices,
         factories: OrganizationFactories) {
        self.organization = organization
        self.presenters = presenters
        self.services = services
        self.factories = factories
    }

    // dependencies
    private let presenters: OrganizationPresenters
    private let services: OrganizationServices
    private let factories: OrganizationFactories

    // views
    private var tabBar: UIViewController {
        if let tabBar = self.weakTabBar {
            return tabBar
        } else {
            let tabBar = OrganizationTabBarViewAlpha()
            tabBar.output = self
            let actions = self.factories.actions.make(output: self)
            let members = self.factories.members.make(organization: self.organization, output: self)
            let commericalOffers = self.factories.commercialOffers.make(output: self)
            tabBar.viewControllers = [actions.viewController,
                                      members.viewController,
                                      commericalOffers.viewController]
            self.weakTabBar = tabBar
            return tabBar
        }
    }

    private weak var weakTabBar: UIViewController?

    // modules
    func action(_ action: PCAction, output: ActionModuleOutput?) -> ActionModule {
        if let actionModule = self.weakActionModule {
            return actionModule
        } else {
            let actionModule = self.factories.action.make(action: action, output: output)
            self.weakActionModule = actionModule
            return actionModule
        }
    }
    private func commercialOffer(_ commercialOffer: PCCommercialOffer, output: CommercialOfferModuleOutput) -> CommercialOfferModule {
        if let commercialOfferModule = self.weakCommercialOfferModule {
            return commercialOfferModule
        } else {
            let commercialOfferModule = self.factories.commercialOffer.make(commercialOffer: commercialOffer, output: output)
            self.weakCommercialOfferModule = commercialOfferModule
            return commercialOfferModule
        }
    }
    private weak var weakActionModule: ActionModule?
    private weak var weakCommercialOfferModule: CommercialOfferModule?

    private var profileImage: UIImage?
    private var changeRoleImage: UIImage?
    private var logoutImage: UIImage?
}

extension OrganizationPresenter: OrganizationTabBarViewOutput {
    func organizationTabBar(view: OrganizationTabBarViewInput, tappenOn menuBarButton: Any) {
        #if SWIFT_PACKAGE
        changeRoleImage = UIImage(named: "refresh", in: Bundle.module, compatibleWith: nil)
        #else
        changeRoleImage = UIImage(named: "refresh", in: Bundle(for: Self.self), compatibleWith: nil)
        #endif

        #if SWIFT_PACKAGE
        logoutImage = UIImage(named: "logout", in: Bundle.module, compatibleWith: nil)
        #else
        logoutImage = UIImage(named: "logout", in: Bundle(for: Self.self), compatibleWith: nil)
        #endif

        #if SWIFT_PACKAGE
        profileImage = UIImage(named: "profile", in: Bundle.module, compatibleWith: nil)
        #else
        profileImage = UIImage(named: "profile", in: Bundle(for: Self.self), compatibleWith: nil)
        #endif

        let profile = MenuItem(title: "Профиль", image: profileImage) { [weak self] in
            guard let sSelf = self else { return }
            sSelf.output?.organization(module: sSelf, userWantsToOpenProfileOf: sSelf.organization)
        }
        let changeRole = MenuItem(title: "Сменить роль", image: changeRoleImage) { [weak self] in
            guard let sSelf = self else { return }
            sSelf.output?.organizationUserWantsToChangeRole(module: sSelf)
        }
        let logout = MenuItem(title: "Выйти", image: logoutImage) { [weak self] in
            guard let sSelf = self else { return }
            sSelf.presenters.confirmation.present(
                title: "Подтвердите выход",
                message: "Вы уверены что хотите выйти?",
                actionTitle: "Выйти", withCancelAction: true) { [weak sSelf] in
                guard let ssSelf = sSelf else { return }
                ssSelf.services.userService.logout { [weak ssSelf] result in
                    guard let sssSelf = ssSelf else { return }
                    switch result {
                    case .success:
                        sssSelf.output?.organizationUserDidLogout(module: sssSelf)
                    case .failure(let error):
                        sssSelf.presenters.error.present(error)
                    }
                }
            }
        }
        self.presenters.menu.present(items: [profile, changeRole, logout])
    }
}

extension OrganizationPresenter: ActionsModuleOutput {
    func actions(module: ActionsModule, didSelect action: PCAction) {
        let actionModule = self.action(action, output: self)
        module.viewController.raise(actionModule.viewController, animated: true)
    }
}

extension OrganizationPresenter: ActionModuleOutput {

}

extension OrganizationPresenter: CommercialOffersModuleOutput {
    func commercialOffers(module: CommercialOffersModule, didSelect commercialOffer: PCCommercialOffer) {
        let commercialOfferModule = self.commercialOffer(commercialOffer, output: self)
        module.viewController.raise(commercialOfferModule.viewController, animated: true)
    }
}

extension OrganizationPresenter: CommercialOfferModuleOutput {

}

extension OrganizationPresenter: MembersModuleOutput {

}
