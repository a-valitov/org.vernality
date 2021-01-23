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

import Foundation
import ErrorPresenter
import ActivityPresenter
import ConfirmationPresenter
import MenuPresenter
#if canImport(PCUserServiceStub)
import PCUserServiceStub
#endif

public final class ReviewFactory {
    #if canImport(PCUserServiceStub)
    public init() {
        let errorPresenter = ErrorPresenterAlertFactory().make()
        let activityPresenter = ActivityPresenterCircleFactory().make()
        let confirmationPresenter = ConfirmationPresenterAlertFactory().make()
        let menuPresenter = MenuPresenterActionSheetFactory().make()

        self.presenters = ReviewPresenters(
            error: errorPresenter,
            activity: activityPresenter,
            confirmation: confirmationPresenter,
            menu: menuPresenter
        )
        
        let userService = PCUserServiceStubFactory().make()
        self.services = ReviewServices(
            userService: userService
        )
    }
    #endif

    public init(presenters: ReviewPresenters,
         services: ReviewServices) {
        self.presenters = presenters
        self.services = services
    }

    public func make(output: ReviewModuleOutput?) -> ReviewModule {
        let presenter = ReviewPresenter(presenters: self.presenters,
                                         services: self.services)
        presenter.output = output
        return presenter
    }

    private let services: ReviewServices
    private let presenters: ReviewPresenters
}
