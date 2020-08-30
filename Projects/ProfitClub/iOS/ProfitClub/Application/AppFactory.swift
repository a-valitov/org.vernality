//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/24/20
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
import Main
import LoginView
import ActivityPresenter
import ErrorPresenter
import PCAuthentication

final class AppFactory {
    lazy var authentication: PCAuthentication = {
        return PCAuthenticationParseFactory().make()
    }()

    func activityPresenter() -> ActivityPresenter {
        return ActivityPresenterCircleFactory().make()
    }

    func errorPresenter() -> ErrorPresenter {
        return ErrorPresenterAlertFactory().make()
    }
}

// MARK: - ViewContollers
extension AppFactory {
    func main(output: MainModuleOutput?) -> UIViewController {
        let main = self.mainFactory.make(output: output)
        return main.view
    }

    func onboard(output: OnboardModuleOutput?) -> OnboardModule {
        let module = self.onboardFactory.make(output: output)
        return module
    }

    func interface(output: InterfaceModuleOutput?) -> InterfaceModule {
        let module = self.interfaceFactory.make(output: output)
        return module
    }
}

// MARK: - Factories
private extension AppFactory {
    var mainFactory: MainModuleFactory {
        return MainModuleFactoryMVC()
    }

    var onboardFactory: OnboardFactory {
        return OnboardFactory(presenters: OnboardPresenters(error: self.errorPresenter(),
                                                            activity: self.activityPresenter()),
                              services: OnboardServices(authentication: self.authentication))
    }

    var interfaceFactory: InterfaceFactory {
        return InterfaceFactory(presenters: InterfacePresenters(error: self.errorPresenter(),
                                                                activity: self.activityPresenter()),
                                services: InterfaceServices(authentication: self.authentication))
    }
}
