//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 22.11.2020
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

final class PastActionViewBeta: UIViewController {
    var output: PastActionViewOutput?
    var pastActionImageUrl: URL? {
        didSet {
            self.updateUIActionImageUrl()
        }
    }
    var pastActionMessage: String? {
        didSet {
            self.updateUIActionMessage()
        }
    }
    var pastActionDescription: String? {
        didSet {
            self.updateUIActionDescription()
        }
    }
    var organizationName: String? {
        didSet {
            self.updateUIOrganizationName()
        }
    }
    var pastActionStartDate: String?
    var pastActionEndDate: String?
    
    @IBOutlet weak var pastActionImageView: UIImageView!
    @IBOutlet weak var organizationNameLabel: UILabel!
    @IBOutlet weak var pastActionMessageLabel: UILabel!
    @IBOutlet weak var pastActionDescriptionLabel: UILabel!
    @IBOutlet weak var actionStartAndEndDate: UILabel!

    @IBAction func cancelButtonTouchUpInside() {
        dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
        actionStartAndEndDate.text = "\(pastActionStartDate ?? "0")-\(pastActionEndDate ?? "0")"
    }
}

extension PastActionViewBeta {
    private func updateUI() {
        self.updateUIActionImageUrl()
        self.updateUIActionMessage()
        self.updateUIActionDescription()
        self.updateUIOrganizationName()
    }

    private func updateUIActionImageUrl() {
        if isViewLoaded {
            self.pastActionImageView.kf.setImage(with: pastActionImageUrl)
        }
    }

    private func updateUIActionMessage() {
        if isViewLoaded {
            self.pastActionMessageLabel.text = self.pastActionMessage
        }
    }

    private func updateUIActionDescription() {
        if isViewLoaded {
            self.pastActionDescriptionLabel.text = self.pastActionDescription
        }
    }

    private func updateUIOrganizationName() {
        if self.isViewLoaded {
            self.organizationNameLabel.text = self.organizationName
        }
    }
}

extension PastActionViewBeta: PastActionViewInput {

}
