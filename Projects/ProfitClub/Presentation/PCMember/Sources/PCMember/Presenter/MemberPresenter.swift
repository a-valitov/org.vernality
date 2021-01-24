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

import Foundation
import UIKit
import ActivityPresenter
import ConfirmationPresenter
import MenuPresenter
import PCModel
import Raise

final class MemberPresenter: MemberModule {
    weak var output: MemberModuleOutput?
    var router: AnyObject?
    var viewController: UIViewController {
        return self.memberCurrentActionsView
    }

    var member: PCMember

    init(member: PCMember,
         presenters: MemberPresenters,
         services: MemberServices) {
        self.member = member
        self.presenters = presenters
        self.services = services
    }

    // dependencies
    private let presenters: MemberPresenters
    private let services: MemberServices

    // views
    private var memberCurrentActionsView: UIViewController {
        if let memberCurrentActionsView = self.weakMemberCurrentActionsView {
            return memberCurrentActionsView
        } else {
            let memberCurrentActionsView = MemberCurrentActionsViewAlpha()
            memberCurrentActionsView.output = self
            self.weakMemberCurrentActionsView = memberCurrentActionsView
            return memberCurrentActionsView
        }
    }
    private func memberCurrentActionView(_ action: PCAction) -> UIViewController {
        if let memberCurrentActionView = self.weakMemberCurrentActionView {
            return memberCurrentActionView
        } else {
            let memberCurrentActionView = MemberCurrentActionViewAlpha()
            memberCurrentActionView.output = self
            memberCurrentActionView.organizationName = action.supplier?.name
            memberCurrentActionView.actionImageUrl = action.imageUrl
            memberCurrentActionView.actionMessage = action.message
            memberCurrentActionView.actionDescription = action.descriptionOf
            memberCurrentActionView.actionLink = action.link
            memberCurrentActionView.actionStartDate = action.startDate
            memberCurrentActionView.actionEndDate = action.endDate
            self.weakMemberCurrentActionView = memberCurrentActionView
            return memberCurrentActionView
        }
    }

    private weak var weakMemberCurrentActionsView: UIViewController?
    private weak var weakMemberCurrentActionView: UIViewController?

    private var profileImage: UIImage?
    private var changeRoleImage: UIImage?
    private var logoutImage: UIImage?
}

extension MemberPresenter: MemberCurrentActionsViewOutput {
    func memberCurrentActionsDidLoad(view: MemberCurrentActionsViewInput) {
        self.services.action.fetchApprovedCurrentActions { [weak self] result in
            switch result {
            case .success(let actions):
                view.actions = actions
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }

    func memberCurrentActions(view: MemberCurrentActionsViewInput, didSelect action: PCAction) {
        let currentActionView = self.memberCurrentActionView(action)
        view.raise(currentActionView, animated: true)
    }

    func memberCurrentActions(view: MemberCurrentActionsViewInput, tappenOn menuBarButton: Any) {
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

        let profile = MenuItem(title: "Профиль", image: profileImage) { [weak self] in
            guard let sSelf = self else { return }
            sSelf.output?.member(module: sSelf, userWantsToOpenProfileOf: sSelf.member)
        }
        let changeRole = MenuItem(title: "Сменить роль", image: changeRoleImage) { [weak self] in
            guard let sSelf = self else { return }
            sSelf.output?.memberUserWantsToChangeRole(module: sSelf)
        }
        let logout = MenuItem(title: "Выйти", image: logoutImage) { [weak self] in
            guard let sSelf = self else { return }
            sSelf.presenters.confirmation.present(title: "Подтвердите выход", message: "Вы уверены что хотите выйти?", actionTitle: "Выйти", withCancelAction: true) { [weak sSelf] in
                guard let ssSelf = sSelf else { return }
                ssSelf.services.user.logout { [weak ssSelf] result in
                    guard let sssSelf = ssSelf else { return }
                    switch result {
                    case .success:
                        sssSelf.output?.memberUserDidLogout(module: sssSelf)
                    case .failure(let error):
                        sssSelf.presenters.error.present(error)
                    }
                }

            }
        }
        self.presenters.menu.present(items: [profile, changeRole, logout])
    }

    func memberCurrentActions(view: MemberCurrentActionsViewInput, userWantsToRefresh sender: Any) {
        self.services.action.fetchApprovedCurrentActions { [weak self] result in
            switch result {
            case .success(let actions):
                view.actions = actions
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }
}

extension MemberPresenter: MemberCurrentActionViewOutput {
    func memberCurrentActionDidLoad(view: MemberCurrentActionViewInput) {
        
    }
}
