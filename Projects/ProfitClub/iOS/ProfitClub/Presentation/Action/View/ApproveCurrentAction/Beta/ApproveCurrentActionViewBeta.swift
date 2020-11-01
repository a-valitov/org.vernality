//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 26.10.2020
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

final class ApproveCurrentActionViewBeta: UIViewController {
    var output: ApproveCurrentActionViewOutput?
    var actionImageUrl: URL? {
        didSet {
            if self.isViewLoaded {
                self.actionImageView.kf.setImage(with: actionImageUrl)
            }
        }
    }
    var actionMessage: String? {
        didSet {
            if self.isViewLoaded {
                self.actionMessageLabel.text = self.actionMessage
            }
        }
    }
    var actionDescription: String? {
        didSet {
            if self.isViewLoaded {
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

    @IBOutlet weak var rejectAction: UIButton! {
        didSet {
            rejectAction.layer.borderWidth = 1
            rejectAction.layer.borderColor = UIColor.black.cgColor
        }
    }
    @IBOutlet weak var actionStartAndEndDateLabel: UILabel!
    
    @IBOutlet weak var actionImageView: UIImageView!
    @IBOutlet weak var actionMessageLabel: UILabel!
    @IBOutlet weak var actionDescriptionLabel: UILabel!
    @IBOutlet weak var organizationNameLabel: UILabel!
    
    @IBAction func cancelTouchUpInside(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func actionLinkTouchUpInside(_ sender: Any) {
        if let url = URL(string: actionLink!) {
            UIApplication.shared.open(url)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.output?.approveCurrentActionDidLoad(view: self)
        actionStartAndEndDateLabel.text = "\(actionStartDate ?? "0")-\(actionEndDate ?? "0")"
    }
}

extension ApproveCurrentActionViewBeta: ApproveCurrentActionViewInput {
}
