//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 08.11.2020
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
import ProfitClubModel

protocol MemberModule: class {
    func open(in main: MainModule?)
}

protocol MemberModuleOutput: class {
    func member(module: MemberModule, userWantsToOpenProfileOf member: PCMember, inside main: MainModule? )
    func member(module: MemberModule, userWantsToLogoutInside main: MainModule?)
    func member(module: MemberModule, userWantsToChangeRole main: MainModule?)
}
