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
            self.updateUIActionImageUrl()
        }
    }
    var actionMessage: String? {
        didSet {
            self.updateUIActionMessage()
        }
    }
    var actionDescription: String? {
        didSet {
            self.updateUIActionDescription()
        }
    }
    var organizationName: String? {
        didSet {
            self.updateUIOrganizationName()
        }
    }
    var actionLink: String?
    var actionStartDate: Date? {
        didSet {
            self.updateUIActionStartAndEndDate()
        }
    }
    var actionEndDate: Date? {
        didSet {
            self.updateUIActionStartAndEndDate()
        }
    }

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
    @IBAction func cancelTouchUpInside() {
        dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.output?.memberCurrentActionDidLoad(view: self)
        self.updateUI()
    }
}

extension MemberCurrentActionViewBeta: MemberCurrentActionViewInput {
    
}

// MARK: - Update UI
extension MemberCurrentActionViewBeta {
    private func updateUI() {
        self.updateUIActionImageUrl()
        self.updateUIActionMessage()
        self.updateUIActionDescription()
        self.updateUIOrganizationName()
        self.updateUIActionStartAndEndDate()
    }

    private func updateUIActionImageUrl() {
        if self.isViewLoaded {
            self.actionImageView.kf.setImage(with: actionImageUrl)
        }
    }

    private func updateUIActionMessage() {
        if self.isViewLoaded {
            self.actionMessageLabel.text = self.actionMessage
        }
    }

    private func updateUIActionDescription() {
        if self.isViewLoaded {
            self.actionDescriptionLabel.text = self.actionDescription
        }
    }

    private func updateUIOrganizationName() {
        if self.isViewLoaded {
            self.organizationNameLabel.text = self.organizationName
        }
    }

    private func updateUIActionStartAndEndDate() {
        if self.isViewLoaded {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            if let actionStartDate = self.actionStartDate,
               let actionEndDate = self.actionEndDate {
                self.actionStartAndEndDate.text = dateFormatter.string(from: actionStartDate) + "-" + dateFormatter.string(from: actionEndDate)
            } else if let actionEndDate = self.actionEndDate {
                self.actionStartAndEndDate.text = dateFormatter.string(from: actionEndDate)
            } else if let actionStartDate = self.actionStartDate {
                self.actionStartAndEndDate.text = dateFormatter.string(from: actionStartDate)
            } else {
                self.actionStartAndEndDate.text = nil
            }
        }
    }
}
