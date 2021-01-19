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

import Foundation
import Main
import ErrorPresenter
import ActivityPresenter
import ConfirmationPresenter
import ProfitClubModel

final class AdminCommercialOfferPresenter: AdminCommercialOfferModule {
    weak var output: AdminCommercialOfferModuleOutput?
    var viewController: UIViewController {
        return self.adminCommercialOffer
    }

    init(commercialOffer: PCCommercialOffer,
         presenters: AdminCommercialOfferPresenters,
         services: AdminCommercialOfferServices) {
        self.commercialOffer = commercialOffer
        self.presenters = presenters
        self.services = services
    }

    private let commercialOffer: PCCommercialOffer

    // dependencies
    private let presenters: AdminCommercialOfferPresenters
    private let services: AdminCommercialOfferServices

    // view
    private var adminCommercialOffer: UIViewController {
        if let adminCommercialOffer = self.weakAdminCommercialOffer {
            return adminCommercialOffer
        } else {
            let adminCommercialOffer = AdminCommercialOfferApplicationViewAlpha()
            adminCommercialOffer.output = self
            self.weakAdminCommercialOffer = adminCommercialOffer
            return adminCommercialOffer
        }
    }
    private weak var weakAdminCommercialOffer: UIViewController?

    // state
    private var fileUrls = [Int: URL]()
}

extension AdminCommercialOfferPresenter: AdminCommercialOfferApplicationViewOutput {
    func adminCommercialOfferApplicationDidLoad(view: AdminCommercialOfferApplicationViewInput) {
        view.commercialOfferImageUrl = self.commercialOffer.imageUrl
        view.commercialOfferMessage = self.commercialOffer.message
        view.organizationName = self.commercialOffer.supplier?.name
        view.attachmentNames = self.commercialOffer.attachmentNames
        view.supplierName = self.commercialOffer.supplier?.contact
    }

    func adminCommercialOfferApplication(view: AdminCommercialOfferApplicationViewInput, didTapOnAttachmentAtIndex index: Int) {
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

    func adminCommercialOfferApplication(view: AdminCommercialOfferApplicationViewInput, userWantsToApprove sender: Any) {
        self.presenters.confirmation.present(title: "Одобрить поставку?", message: "Одобрить поставку от \(view.supplierName ?? "")", actionTitle: "Одобрить", withCancelAction: true) { [weak self] in
            guard let commercialOffer = self?.commercialOffer else { return }
            self?.services.commercialOffer.approve(commercialOffer: commercialOffer, result: { [weak self] (result) in
                guard let sSelf = self else { return }
                switch result {
                case .success(let commercialOffer):
                    sSelf.output?.adminCommercialOffer(module: sSelf, didApprove: commercialOffer)
                case .failure(let error):
                    sSelf.presenters.error.present(error)
                }
            })
        }
    }

    func adminCommercialOfferApplication(view: AdminCommercialOfferApplicationViewInput, userWantsToReject sender: Any) {
        self.presenters.confirmation.present(title: "Отклонить поставку?", message: "Отклонить поставку от \(view.supplierName ?? "")", actionTitle: "Отклонить", withCancelAction: true) { [weak self] in
            guard let commercialOffer = self?.commercialOffer else { return }
            self?.services.commercialOffer.reject(commercialOffer: commercialOffer, result: { [weak self] (result) in
                guard let sSelf = self else { return }
                switch result {
                case .success(let commercialOffer):
                    sSelf.output?.adminCommercialOffer(module: sSelf, didReject: commercialOffer)
                case .failure(let error):
                    sSelf.presenters.error.present(error)
                }
            })
        }

    }


}
