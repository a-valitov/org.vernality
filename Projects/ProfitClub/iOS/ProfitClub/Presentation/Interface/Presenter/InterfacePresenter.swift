//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/29/20
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

final class InterfacePresenter: InterfaceModule {
    weak var output: InterfaceModuleOutput?

    init(presenters: InterfacePresenters,
         services: InterfaceServices) {
        self.presenters = presenters
        self.services = services
    }

    func start(in main: MainModule?) {
        let view = InterfaceViewAlpha()
        let user = self.services.authentication.user
        view.member = user?.member
        view.suppliers = user?.suppliers
        view.organizations = user?.organizations
        main?.push(view, animated: false)
    }

    // dependencies
    private let presenters: InterfacePresenters
    private let services: InterfaceServices
}
