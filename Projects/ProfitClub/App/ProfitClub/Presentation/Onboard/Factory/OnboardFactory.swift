//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/26/20
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

final class OnboardFactory {
    init(presenters: OnboardPresenters,
         services: OnboardServices) {
        self.presenters = presenters
        self.services = services
    }

    func make(output: OnboardModuleOutput?) -> OnboardModule {
        let presenter = OnboardPresenter(presenters: self.presenters,
                                         services: self.services)
        presenter.output = output
        return presenter
    }

    private let services: OnboardServices
    private let presenters: OnboardPresenters
}
