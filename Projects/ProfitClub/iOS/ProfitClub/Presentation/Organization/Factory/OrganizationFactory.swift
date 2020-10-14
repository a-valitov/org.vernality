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
import ErrorPresenter
import ActivityPresenter

final class OrganizationFactory {
    init(presenters: OrganizationPresenters,
         services: OrganizationServices) {
        self.presenters = presenters
        self.services = services
    }

    func make(output: OrganizationModuleOutput?) -> OrganizationModule {
        let router = OrganizationRouter()
        let presenter = OrganizationPresenter(presenters: self.presenters,
                                              services: self.services)
        presenter.output = output
        presenter.router = router
        return presenter
    }

    private let services: OrganizationServices
    private let presenters: OrganizationPresenters
}
