//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Rinat Enikeev on 17.01.2021
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
import ProfitClubModel

enum AppPush {
    case actionCreated(actionId: String)

    static func parse(from userInfo: [AnyHashable : Any]) -> AppPush? {
        if let type = userInfo["type"] as? String {
            switch type {
            case "action_created":
                if let actionId = userInfo["action_id"] as? String {
                    return .actionCreated(actionId: actionId)
                } else {
                    assertionFailure("missing actionId in payload")
                    return nil
                }
            default:
                return nil
            }
        } else {
            return nil
        }
    }
}


