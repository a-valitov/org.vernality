//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Rinat Enikeev on 24.01.2021
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
import PCModel

protocol MemberRouterDelegate: class {
    func memberUserDidLogout(router: MemberRouter)
    func memberUserWantsToChangeRole(router: MemberRouter)
}

final class MemberRouter {
    var viewController: UIViewController {
        return self.memberModule.viewController
    }
    var navigationController: UINavigationController {
        if let navigationController = self.viewController.navigationController {
            return navigationController
        } else if let navigationController = self.weakNavigationController {
            return navigationController
        } else {
            let navigationController = UINavigationController(
                rootViewController: self.viewController
            )
            self.weakNavigationController = navigationController
            return navigationController
        }
    }
    weak var delegate: MemberRouterDelegate?

    init(user: PCUser, member: PCMember) {
        self.user = user
        self.member = member
    }

    private var memberModule: MemberModule {
        if let memberModule = self.weakMemberModule {
            return memberModule
        } else {
            let memberModule = self.memberFactory(
                user: self.user,
                member: self.member
            ).make(member: self.member, output: self)
            self.weakMemberModule = memberModule
            return memberModule
        }
    }
    private weak var weakMemberModule: MemberModule?

    private let user: PCUser
    private let member: PCMember
    private weak var weakNavigationController: UINavigationController?
}

// MARK: - ModuleOutput
extension MemberRouter: MemberModuleOutput {
    func member(module: MemberModule,
                  userWantsToOpenProfileOf member: PCMember) {

    }
    
    func memberUserDidLogout(module: MemberModule) {
        self.delegate?.memberUserDidLogout(router: self)
    }

    func memberUserWantsToChangeRole(module: MemberModule) {
        self.delegate?.memberUserWantsToChangeRole(router: self)
    }
}

// MARK: - Factory
extension MemberRouter: Router {
    func memberFactory(user: PCUser, member: PCMember) -> MemberFactory {
        return MemberFactory(
            presenters: MemberPresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter(),
                confirmation: self.confirmationPresenter(),
                menu: self.menuPresenter()
            ),
            services: MemberServices(
                user: self.userService(user: user),
                action: self.actionService()
            )
        )
    }
}
