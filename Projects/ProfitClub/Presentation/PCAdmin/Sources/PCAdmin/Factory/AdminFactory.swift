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

import Foundation
import ErrorPresenter
import ActivityPresenter
import ConfirmationPresenter
import MenuPresenter
import PCModel
#if canImport(PCAuthenticationStub)
import PCUserServiceStub
#endif
#if canImport(PCOrganizationServiceStub)
import PCOrganizationServiceStub
#endif

public final class AdminFactory {
    #if canImport(PCUserServiceStub)
    public init(user: PCUser) {
        let errorPresenter = ErrorPresenterAlertFactory().make()
        let activityPresenter = ActivityPresenterCircleFactory().make()
        let confirmationPresenter = ConfirmationPresenterAlertFactory().make()
        let menuPresenter = MenuPresenterActionSheetFactory().make()

        self.presenters = AdminPresenters(
            error: errorPresenter,
            activity: activityPresenter,
            confirmation: confirmationPresenter,
            menu: menuPresenter
        )
        let userService = PCUserServiceStubFactory(user: user).make()
        self.services = AdminServices(
            userService: userService
        )
        let organizationFactory = PCOrganizationServiceStubFactory()
        self.factories = AdminFactories(
            user: user,
            organizationService: organizationFactory
        )
    }
    #endif

    public init(presenters: AdminPresenters,
                services: AdminServices,
                factories: AdminFactories) {
        self.presenters = presenters
        self.services = services
        self.factories = factories
    }

    public func make(output: AdminModuleOutput?) -> AdminModule {
        let presenter = AdminPresenter(presenters: self.presenters,
                                       services: self.services,
                                       factories: self.factories)
        presenter.output = output
        return presenter
    }

    private let presenters: AdminPresenters
    private let services: AdminServices
    private let factories: AdminFactories
}
