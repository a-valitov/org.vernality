//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 01.11.2020
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

protocol ApproveCommercialOfferViewInput: UIViewController {
    var commercialOfferImageUrl: URL? { get set }
    var commercialOfferMessage: String? { get set }
    var organizationName: String? { get set }
    var attachmentName: String? { get set }
    var attachmentFileUrl: URL? { get set }

    func showAttachment()
}

protocol ApproveCommercialOfferViewOutput {
    func approveCommercialOfferDidLoad(view: ApproveCommercialOfferViewInput)
    func approveCommercialOfferDidTapOnAttachment(view: ApproveCommercialOfferViewInput)
}
