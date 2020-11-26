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

final class MemberRouter {
    weak var main: MainModule?

    @discardableResult
    func openMemberCurrentActions(output: MemberCurrentActionsViewOutput?) -> MemberCurrentActionsViewInput {
        let storyboard = UIStoryboard(name: "MemberCurrentActionsViewBeta", bundle: nil)
        let actions = storyboard.instantiateInitialViewController() as! MemberCurrentActionsViewBeta
        actions.output = output
        self.main?.push(actions, animated: true)
        return actions
    }

    @discardableResult
    func openMemberCurrentAction(action: PCAction, output: MemberCurrentActionViewOutput?) -> MemberCurrentActionViewInput {
        let storyboard = UIStoryboard(name: "MemberCurrentActionViewBeta", bundle: nil)
        let memberCurrentAction = storyboard.instantiateInitialViewController() as! MemberCurrentActionViewBeta
        memberCurrentAction.output = output
        memberCurrentAction.organizationName = action.supplier?.name
        memberCurrentAction.actionImageUrl = action.imageUrl
        memberCurrentAction.actionMessage = action.message
        memberCurrentAction.actionDescription = action.descriptionOf
        memberCurrentAction.actionLink = action.link
        memberCurrentAction.actionStartDate = action.startDate
        memberCurrentAction.actionEndDate = action.endDate
        self.main?.raise(memberCurrentAction, animated: true)
        return memberCurrentAction
    }
}
