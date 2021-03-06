//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 15.11.2020
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
import ActivityPresenter
import ErrorPresenter
import PCUserService

public struct MemberProfilePresenters {
    let error: ErrorPresenter
    let activity: ActivityPresenter

    public init(
        error: ErrorPresenter,
        activity: ActivityPresenter
    ) {
        self.error = error
        self.activity = activity
    }
}

public struct MemberProfileServices {
    let user: PCUserService

    public init(user: PCUserService) {
        self.user = user
    }
}
