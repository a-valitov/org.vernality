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
import QuickLook

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
    var organizationName: String? {
        didSet {
            if self.isViewLoaded {
                self.organizationNameLabel.text = self.organizationName
            }
        }
    }
    var attachmentName: String? {
        didSet {
            if self.isViewLoaded {
                self.openFile.setTitle(attachmentName, for: .normal)
            }
        }
    }

    var attachmentFileUrl: URL?

    @IBOutlet weak var organizationNameLabel: UILabel!
    @IBOutlet weak var commercialOfferImageView: UIImageView!
    @IBOutlet weak var commercialOfferMessageLabel: UILabel!
    @IBOutlet weak var rejectCommercialOffer: UIButton! {
        didSet {
            rejectCommercialOffer.layer.borderWidth = 1
            rejectCommercialOffer.layer.borderColor = UIColor.black.cgColor
        }
    }
    @IBOutlet weak var openFile: UIButton!
    
    @IBAction func cancelTouchUpInside(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func openFileTouchUpInside(_ sender: UIButton) {
        self.output?.approveCommercialOfferDidTapOnAttachment(view: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.output?.approveCommercialOfferDidLoad(view: self)
    }
}

extension ApproveCommercialOfferViewBeta: ApproveCommercialOfferViewInput {
    func showAttachment() {
        assert(self.attachmentFileUrl != nil)
        let quickLookViewController = QLPreviewController()
        quickLookViewController.dataSource = self
        self.present(quickLookViewController, animated: true)
    }
}

// MARK: - QLPreviewControllerDataSource
extension ApproveCommercialOfferViewBeta: QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return self.attachmentFileUrl == nil ? 0 : 1
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        guard let fileUrl = self.attachmentFileUrl else {
            fatalError()
        }
        return fileUrl as NSURL
    }
}
