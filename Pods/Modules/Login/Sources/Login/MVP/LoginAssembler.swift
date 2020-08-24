//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/21/20
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
import Authentication
import ErrorPresenter
import ActivityPresenter

public final class LoginAssembler {
    public struct Dependencies {
        let authentication: Authentication
        let errorPresenter: ErrorPresenter
        let activityPresenter: ActivityPresenter

        public init(authentication: Authentication,
                    errorPresenter: ErrorPresenter,
                    activityPresenter: ActivityPresenter) {
            self.authentication = authentication
            self.errorPresenter = errorPresenter
            self.activityPresenter = activityPresenter
        }
    }

    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    public func assemble(output: LoginModuleOutput) -> LoginModule & LoginViewOutput {
        let presenter = LoginPresenter(authentication: self.dependencies.authentication,
                                       errorPresenter: self.dependencies.errorPresenter,
                                       activityPresenter: self.dependencies.activityPresenter)
        presenter.output = output
        return presenter
    }

    private let dependencies: Dependencies
}
