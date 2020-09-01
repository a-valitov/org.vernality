//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/30/20
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

final class ReviewRouter {
    weak var main: MainModule?

    @discardableResult
    func openReview(_ user: AnyPCUser?, output: ReviewViewOutput?) -> ReviewViewInput {
        let storyboard = UIStoryboard(name: "ReviewViewBeta", bundle: nil)
        let reviewView = storyboard.instantiateInitialViewController() as! ReviewViewBeta
        reviewView.output = output
        reviewView.username = user?.username
        reviewView.member = user?.member?.any
        reviewView.organizations = user?.organizations?.map({ $0.any }) ?? []
        reviewView.suppliers = user?.suppliers?.map({ $0.any }) ?? []
        self.main?.push(reviewView, animated: true)
        return reviewView
    }

}