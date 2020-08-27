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
import Main
import PCAuthentication

final class MainRouter {
    init(mainModule: MainModule,
         authentication: PCAuthentication) {
        self.authentication = authentication
        self.mainModule = mainModule
    }

    // dependencies
    private let authentication: PCAuthentication

    // modules
    private weak var mainModule: MainModule?

    // helpers
    private var isLoggedIn: Bool {
        return self.authentication.user != nil
    }
}

extension MainRouter: MainModuleOutput {
    func mainDidLoad(module: MainModule) {
        if self.isLoggedIn {

        } else {
            let onboard = Assembler.shared.onboard(output: self)
            onboard.start(in: self.mainModule)
        }
    }

    func mainWillAppear(module: MainModule) {

    }
}

extension MainRouter: OnboardModuleOutput {

}
