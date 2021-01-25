//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Rinat Enikeev on 18.01.2021
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
import PCModel
#if canImport(PCUserServiceStub)
import PCUserServiceStub
#endif

public final class AddRoleFactory {
    #if canImport(PCUserServiceStub)
    public init(user: PCUser) {
        let errorPresenter = ErrorPresenterAlertFactory().make()
        let activityPresenter = ActivityPresenterCircleFactory().make()
        let confirmationPresenter = ConfirmationPresenterAlertFactory().make()

        self.presenters = AddRolePresenters(
            error: errorPresenter,
            activity: activityPresenter,
            confirmation: confirmationPresenter
        )
        let userService = PCUserServiceStubFactory(user: user).make()
        self.services = AddRoleServices(
            user: userService
        )
    }
    #endif

    public init(presenters: AddRolePresenters,
                services: AddRoleServices) {
        self.presenters = presenters
        self.services = services
    }

    public func make(output: AddRoleModuleOutput?) -> AddRoleModule {
        let presenter = AddRolePresenter(presenters: self.presenters,
                                         services: self.services)
        presenter.output = output
        return presenter
    }

    private let services: AddRoleServices
    private let presenters: AddRolePresenters
}
