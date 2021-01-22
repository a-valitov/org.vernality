//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Macbook on 12.01.2021
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

protocol AdminCommercialOfferApplicationViewInput: UIViewController {
    var commercialOfferImageUrl: URL? { get set }
    var commercialOfferMessage: String? { get set }
    var organizationName: String? { get set }
    var attachmentNames: [String] { get set }
    var supplierName: String? { get set }

    func showAttachment(fileUrl: URL)
}

protocol AdminCommercialOfferApplicationViewOutput {
    func adminCommercialOfferApplicationDidLoad(view: AdminCommercialOfferApplicationViewInput)
    func adminCommercialOfferApplication(view: AdminCommercialOfferApplicationViewInput, didTapOnAttachmentAtIndex index: Int)
    func adminCommercialOfferApplication(view: AdminCommercialOfferApplicationViewInput, userWantsToApprove sender: Any)
    func adminCommercialOfferApplication(view: AdminCommercialOfferApplicationViewInput, userWantsToReject sender: Any)
}

