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

protocol MemberProfileRouterDelegate: class {
    func memberProfile(router: MemberProfileRouter, didUpdate member: PCMember)
}

final class MemberProfileRouter {
    var viewController: UIViewController {
        return self.memberProfileModule.viewController
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
    weak var delegate: MemberProfileRouterDelegate?

    init(user: PCUser, member: PCMember) {
        self.user = user
        self.member = member
    }

    private var memberProfileModule: MemberProfileModule {
        if let memberProfileModule = self.weakMemberProfileModule {
            return memberProfileModule
        } else {
            let memberProfileModule = self.memberProfileFactory(
                user: self.user,
                member: self.member
            ).make(member: member, output: self)
            memberProfileModule.router = self
            self.weakMemberProfileModule = memberProfileModule
            return memberProfileModule
        }
    }
    private weak var weakMemberProfileModule: MemberProfileModule?

    private let user: PCUser
    private let member: PCMember
    private weak var weakNavigationController: UINavigationController?
}

// MARK: - ModuleOutput
extension MemberProfileRouter: MemberProfileModuleOutput {
    func memberProfile(module: MemberProfileModule,
                         didUpdate member: PCMember) {
        self.delegate?.memberProfile(router: self, didUpdate: member)
    }
}

// MARK: - Factory
extension MemberProfileRouter: Router {
    func memberProfileFactory(user: PCUser, member: PCMember) -> MemberProfileFactory {
        return MemberProfileFactory(
            presenters: MemberProfilePresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter()
            ),
            services: MemberProfileServices(
                user: self.userService(user: user)
            )
        )
    }
}
