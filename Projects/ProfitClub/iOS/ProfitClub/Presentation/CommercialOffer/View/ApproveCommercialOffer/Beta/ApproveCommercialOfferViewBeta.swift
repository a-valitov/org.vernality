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
import Kingfisher

final class ApproveCommercialOfferViewBeta: UIViewController {
    var output: ApproveCommercialOfferViewOutput?
    var commercialOfferImageUrl: URL? {
        didSet {
            if self.isViewLoaded {
                self.commercialOfferImageView.kf.setImage(with: commercialOfferImageUrl)
            }
        }
    }
    var commercialOfferMessage: String? {
        didSet {
            if self.isViewLoaded {
                self.commercialOfferMessageLabel.text = self.commercialOfferMessage
            }
        }
    }
    @IBOutlet weak var commercialOfferImageView: UIImageView!
    @IBOutlet weak var commercialOfferMessageLabel: UILabel!
    @IBOutlet weak var rejectCommercialOffer: UIButton! {
        didSet {
            rejectCommercialOffer.layer.borderWidth = 1
            rejectCommercialOffer.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    @IBAction func cancelTouchUpInside(_ sender: Any) {
        dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.output?.approveCommercialOfferDidLoad(view: self)
    }
}

extension ApproveCommercialOfferViewBeta: ApproveCommercialOfferViewInput {
    
}
