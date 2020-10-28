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

    @IBOutlet weak var rejectAction: UIButton! {
        didSet {
            rejectAction.layer.borderWidth = 1
            rejectAction.layer.borderColor = UIColor.black.cgColor
        }
    }

    @IBOutlet weak var actionImageView: UIImageView!
    
    @IBAction func cancelTouchUpInside(_ sender: Any) {
        dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.output?.approveCurrentActionDidLoad(view: self)
    }
}

extension ApproveCurrentActionViewBeta: ApproveCurrentActionViewInput {
}
