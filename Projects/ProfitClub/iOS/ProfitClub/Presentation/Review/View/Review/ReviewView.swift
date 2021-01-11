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

import UIKit
import ProfitClubModel

protocol ReviewViewInput: UIViewController {
    var members: [AnyPCMember] { get set }
    var organizations: [AnyPCOrganization] { get set }
    var suppliers: [AnyPCSupplier] { get set }
}

protocol ReviewViewOutput {
    func review(view: ReviewViewInput, tappenOn menuBarButton: Any)
    func review(view: ReviewViewInput, userWantsToRefresh sender: Any)
    func reviewUserDidTapOnAdmin(view: ReviewViewInput)
    func review(view: ReviewViewInput, userTappedOn supplier: PCSupplier)
    func review(view: ReviewViewInput, userTappedOn organization: PCOrganization)
    func review(view: ReviewViewInput, userTappedOn member: PCMember)
    
}
