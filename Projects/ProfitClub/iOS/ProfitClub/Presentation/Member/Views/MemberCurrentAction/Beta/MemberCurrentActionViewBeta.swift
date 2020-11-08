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

import UIKit
import Kingfisher

final class MemberCurrentActionViewBeta: UIViewController {
    var output: MemberCurrentActionViewOutput?
    var actionImageUrl: URL? {
        didSet {
            if isViewLoaded {
                self.actionImageView.kf.setImage(with: actionImageUrl)
            }
        }
    }
    var actionMessage: String? {
        didSet {
            if isViewLoaded {
                self.actionMessageLabel.text = self.actionMessage
            }
        }
    }
    var actionDescription: String? {
        didSet {
            if isViewLoaded {
                self.actionDescriptionLabel.text = self.actionDescription
            }
        }
    }
    var organizationName: String? {
        didSet {
            if self.isViewLoaded {
                self.organizationNameLabel.text = self.organizationName
            }
        }
    }
    var actionLink: String?
    var actionStartDate: String?
    var actionEndDate: String?

    @IBOutlet weak var actionImageView: UIImageView!
    @IBOutlet weak var organizationNameLabel: UILabel!
    @IBOutlet weak var actionMessageLabel: UILabel!
    @IBOutlet weak var actionDescriptionLabel: UILabel!
    @IBOutlet weak var actionStartAndEndDate: UILabel!
    
    @IBAction func actionLinkTouchUpInside(_ sender: UIButton) {
        if let url = URL(string: actionLink!) {
            UIApplication.shared.open(url)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.output?.memberCurrentActionDidLoad(view: self)
        actionStartAndEndDate.text = "\(actionStartDate ?? "0")-\(actionEndDate ?? "0")"
    }
}

extension MemberCurrentActionViewBeta: MemberCurrentActionViewInput {
    
}
