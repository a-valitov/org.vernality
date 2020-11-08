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

import Foundation
import Main
import ErrorPresenter
import ActivityPresenter
import ProfitClubModel

final class CommercialOfferPresenter: CommercialOfferModule {
    weak var output: CommercialOfferModuleOutput?
    var router: CommercialOfferRouter?

    init(commercialOffer: PCCommercialOffer,
         presenters: CommercialOfferPresenters,
         services: CommercialOfferServices) {
        self.commercialOffer = commercialOffer
        self.presenters = presenters
        self.services = services
    }

    func open(in main: MainModule?) {
        self.router?.main = main
        self.router?.openCommercialOfferView(output: self)
    }

    private let commercialOffer: PCCommercialOffer

    // dependencies
    private let presenters: CommercialOfferPresenters
    private let services: CommercialOfferServices

    // state
    private var fileUrls = [Int: URL]()
}

extension CommercialOfferPresenter: ApproveCommercialOfferViewOutput {
    func approveCommercialOfferDidLoad(view: ApproveCommercialOfferViewInput) {
        view.commercialOfferImageUrl = self.commercialOffer.imageUrl
        view.commercialOfferMessage = self.commercialOffer.message
        view.organizationName = self.commercialOffer.supplier?.name
        view.attachmentNames = self.commercialOffer.attachmentNames
    }

    func approveCommercialOffer(view: ApproveCommercialOfferViewInput, didTapOOnAttachmentAtIndex index: Int) {
        if let fileUrl = self.fileUrls[index] {
            view.showAttachment(fileUrl: fileUrl)
        } else {
            self.presenters.activity.increment()
            self.services.commercialOffer.loadAttachment(at: index, for: self.commercialOffer) { [weak self] result in
                self?.presenters.activity.decrement()
                DispatchQueue.main.async {
                    switch result {
                    case .success(let fileUrl):
                        self?.fileUrls[index] = fileUrl
                        view.showAttachment(fileUrl: fileUrl)
                    case .failure(let error):
                        self?.presenters.error.present(error)
                    }
                }
            }
        }
    }

}
