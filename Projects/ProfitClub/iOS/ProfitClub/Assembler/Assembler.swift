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
import Authentication
import Login
import LoginView
import ActivityPresenter
import ErrorPresenter

final class Assembler {
    static let shared = Assembler()
    lazy var authentication: Authentication = {
        return AuthenticationParseFactory().make()
    }()
    lazy var activityPresenter: ActivityPresenter = {
        return ActivityPresenterCircleFactory().make()
    }()
    lazy var errorPresenter: ErrorPresenter = {
        return ErrorPresenterAlertFactory().make()
    }()
}

// MARK: - ViewContollers
extension Assembler {
    func main() -> UIViewController {
        let router = MainRouter(authentication: self.authentication)
        let module = self.mainFactory.make(output: router)
        return module
    }

    func login(output: LoginModuleOutput) -> UIViewController {
        var module = self.loginFactory.make(output: output)
        let view = self.loginViewFactory.makeView(module)
        module.view = view
        return view
    }
}

// MARK: - Services
extension Assembler {
}

// MARK: - Factories
private extension Assembler {
    var mainFactory: MainModuleFactory {
        return MainModuleFactoryMVC()
    }

    var loginFactory: LoginFactory {
        let dependencies = LoginFactory
            .Dependencies(authentication: self.authentication,
                          errorPresenter: self.errorPresenter,
                          activityPresenter: self.activityPresenter)
        return LoginFactory(dependencies: dependencies)
    }

    var loginViewFactory: LoginViewFactory {
        return LoginViewFactoryProfitClub()
    }
}
