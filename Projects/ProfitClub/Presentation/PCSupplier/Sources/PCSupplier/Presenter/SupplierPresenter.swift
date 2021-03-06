//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 20.10.2020
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
import UIKit
import ErrorPresenter
import ActivityPresenter
import ConfirmationPresenter
import MenuPresenter
import PCModel

final class SupplierPresenter: SupplierModule {
    weak var output: SupplierModuleOutput?
    var router: AnyObject?
    var supplier: PCSupplier
    var viewController: UIViewController {
        return self.supplierView
    }

    init(supplier: PCSupplier,
         presenters: SupplierPresenters,
         services: SupplierServices) {
        self.supplier = supplier
        self.presenters = presenters
        self.services = services
    }

    // dependencies
    private let presenters: SupplierPresenters
    private let services: SupplierServices

    // views
    private var supplierView: UIViewController {
        if let supplierView = self.weakSupplierView {
            return supplierView
        } else {
            let supplierView = SupplierViewAlpha()
            supplierView.output = self
            self.weakSupplierView = supplierView
            return supplierView
        }
    }
    private var supplierActionsView: UIViewController {
        if let supplierActionsView = self.weakSupplierActionsView {
            return supplierActionsView
        } else {
            let supplierActionsView = SupplierActionsViewAlpha()
            supplierActionsView.output = self
            self.weakSupplierActionsView = supplierActionsView
            return supplierActionsView
        }
    }
    private var supplierCommercialOfferView: UIViewController {
        if let supplierCommercialOfferView = self.weakSupplierCommercialOfferView {
            return supplierCommercialOfferView
        } else {
            let supplierCommercialOfferView = SupplierCommercialOfferViewAlpha()
            supplierCommercialOfferView.output = self
            self.weakSupplierCommercialOfferView = supplierCommercialOfferView
            return supplierCommercialOfferView
        }
    }

    private weak var weakSupplierView: UIViewController?
    private weak var weakSupplierActionsView: UIViewController?
    private weak var weakSupplierCommercialOfferView: UIViewController?

    private var profileImage: UIImage?
    private var changeRoleImage: UIImage?
    private var logoutImage: UIImage?
}

extension SupplierPresenter: SupplierViewOutput {
    func supplierView(view: SupplierViewInput, supplierWantsToCreateAction sender: Any) {
        view.navigationController?.pushViewController(self.supplierActionsView, animated: true)
    }

    func supplier(view: SupplierViewInput, wantsToCreateCommercialOffer sender: Any) {
        view.navigationController?.pushViewController(self.supplierCommercialOfferView, animated: true)
    }

    func supplier(view: SupplierViewInput, tappenOn menuBarButton: Any) {
        self.showMenu()
    }
}

extension SupplierPresenter: SupplierActionsOutput {
    func supplierActionsDidFinish(view: SupplierActionsInput) {
        guard let message = view.message, !message.isEmpty else {
            self.presenters.error.present(SupplierError.actionMessageIsEmpty)
            return
        }
        guard let descriptionOf = view.descriptionOf, !descriptionOf.isEmpty, descriptionOf != "?????????????? ???????????????? ??????????" else {
            self.presenters.error.present(SupplierError.actionDescriptionOfIsEmpty)
            return
        }
        guard let link = view.link, !link.isEmpty else {
            self.presenters.error.present(SupplierError.actionLinkIsEmpty)
            return
        }
        guard let image = view.image else {
            self.presenters.error.present(SupplierError.actionImageIsNil)
            return
        }
        guard let startDate = view.startDate else {
            self.presenters.error.present(SupplierError.actionStartDateIsEmpty)
            return
        }
        guard let endDate = view.endDate else {
            self.presenters.error.present(SupplierError.actionEndDateIsEmpty)
            return
        }
        if (endDate < Date()) {
            self.presenters.error.present(SupplierError.actionEndDateIsInPast)
            return
        }
        if (endDate < startDate) {
            self.presenters.error.present(SupplierError.actionEndDateIsEarlierThanStartDate)
            return
        }

        var action = PCActionStruct()
        action.message = message
        action.descriptionOf = descriptionOf
        action.link = link
        action.image = image
        action.startDate = startDate
        action.endDate = endDate
        action.status = .onReview
        action.supplier = self.supplier

        self.presenters.confirmation.present(title: "?????????????????? ?? ???????????????????", message: "?????????? ?????????????????????? ?????????? ???????????? ?????????????????? ????????????????????????", actionTitle: "??????????????????", withCancelAction: true) { [weak self] in
            guard let sSelf = self else { return }
            sSelf.presenters.activity.increment()
            sSelf.services.action.add(action: action) { [weak sSelf] result in
                sSelf?.presenters.activity.decrement()
                switch result {
                case .success:
                    view.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    sSelf?.presenters.error.present(error)
                }
            }
        }
    }

    func supplierActions(view: SupplierActionsInput, tappenOn menuBarButton: Any) {
        self.showMenu()
    }
}

extension SupplierPresenter: SupplierCommercialOfferOutput {
    func supplierCommercialOfferDidFinish(view: SupplierCommercialOfferInput) {
        guard let message = view.message, !message.isEmpty, message != "?????????????? ??????????????????" else {
            self.presenters.error.present(SupplierError.commercialOfferMessageIsEmpty)
            return
        }
        guard let image = view.image else {
            self.presenters.error.present(SupplierError.commercialOfferImageIsNil)
            return
        }
        
        var offer = PCCommercialOfferStruct()
        offer.message = message
        offer.image = image
        offer.supplier = self.supplier
        offer.attachments = view.attachments
        offer.attachmentNames = view.attachmentNames
        offer.status = .onReview

        self.presenters.confirmation.present(title: "?????????????????? ?? ???????????????????", message: "?????????? ?????????????????????? ???????????????????????? ?????????????????????? ???????????? ?????????????????? ??????????????????????????", actionTitle: "??????????????????", withCancelAction: true) { [weak self] in
            guard let sSelf = self else { return }
            sSelf.presenters.activity.increment()
            sSelf.services.commercialOffer.add(offer: offer) { [weak sSelf] result in
                sSelf?.presenters.activity.decrement()
                switch result {
                case .success:
                    view.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    sSelf?.presenters.error.present(error)
                }
            }
        }
    }

    func supplierCommercialOffer(view: SupplierCommercialOfferInput, tappenOn menuBarButton: Any) {
        self.showMenu()
    }
}

extension SupplierPresenter {
    func showMenu() {
        #if SWIFT_PACKAGE
        changeRoleImage = UIImage(named: "refresh", in: Bundle.module, compatibleWith: nil)
        #else
        changeRoleImage = UIImage(named: "refresh", in: Bundle(for: Self.self), compatibleWith: nil)
        #endif

        #if SWIFT_PACKAGE
        logoutImage = UIImage(named: "logout", in: Bundle.module, compatibleWith: nil)
        #else
        logoutImage = UIImage(named: "logout", in: Bundle(for: Self.self), compatibleWith: nil)
        #endif

        #if SWIFT_PACKAGE
        profileImage = UIImage(named: "profile", in: Bundle.module, compatibleWith: nil)
        #else
        profileImage = UIImage(named: "profile", in: Bundle(for: Self.self), compatibleWith: nil)
        #endif

        let profile = MenuItem(title: "??????????????", image: profileImage) { [weak self] in
            guard let sSelf = self else { return }
            sSelf.output?.supplier(module: sSelf, userWantsToOpenProfileOf: sSelf.supplier)
        }
        let changeRole = MenuItem(title: "?????????????? ????????", image: changeRoleImage) { [weak self] in
            guard let sSelf = self else { return }
            sSelf.output?.supplierUserWantsToChangeRole(module: sSelf)
        }
        let logout = MenuItem(title: "??????????", image: logoutImage) { [weak self] in
            guard let sSelf = self else { return }
            sSelf.presenters.confirmation.present(
                title: "?????????????????????? ??????????",
                message: "???? ??????????????, ?????? ???????????? ???????????",
                actionTitle: "??????????", withCancelAction: true) { [weak sSelf] in
                guard let ssSelf = sSelf else { return }
                ssSelf.services.user.logout { [weak ssSelf] result in
                    guard let sssSelf = ssSelf else { return }
                    switch result {
                    case .success:
                        sssSelf.output?.supplierUserDidLogout(module: sssSelf)
                    case .failure(let error):
                        sssSelf.presenters.error.present(error)
                    }
                }

            }
        }
        self.presenters.menu.present(items: [profile, changeRole, logout])
    }
}
