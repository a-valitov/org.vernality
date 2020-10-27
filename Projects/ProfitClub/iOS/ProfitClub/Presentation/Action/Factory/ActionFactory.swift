//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 26.10.2020
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

final class ActionFactory {
    init(presenters: ActionPresenters,
         services: ActionServices) {
        self.presenters = presenters
        self.services = services
    }

    func make(output: ActionModuleOutput?) -> ActionModule {
        let router = ActionRouter()
        let presenter = ActionPresenter(presenters: self.presenters,
                                                      services: self.services)
        presenter.output = output
        presenter.router = router
        return presenter
    }

    private let services: ActionServices
    private let presenters: ActionPresenters
}
