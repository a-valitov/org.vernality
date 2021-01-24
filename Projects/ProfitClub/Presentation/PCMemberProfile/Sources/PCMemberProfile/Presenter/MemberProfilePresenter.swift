//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 15.11.2020
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
import PCModel

final class MemberProfilePresenter: MemberProfileModule {
    weak var output: MemberProfileModuleOutput?
    var router: AnyObject?
    var viewController: UIViewController {
        return self.view
    }

    init(member: PCMember,
         presenters: MemberProfilePresenters,
         services: MemberProfileServices) {
        self.member = member
        self.presenters = presenters
        self.services = services
    }
    
    // dependencies
    private let presenters: MemberProfilePresenters
    private let services: MemberProfileServices

    // state
    private var member: PCMember

    // view
    private var view: UIViewController {
        if let view = self.weakView {
            return view
        } else {
            let view = MemberProfileViewAlpha()
            view.output = self
            view.organizationName = member.organization?.name
            view.memberFirstName = member.firstName
            view.memberLastName = member.lastName
            view.userEmail = member.owner?.username
            view.memberImageUrl = member.imageUrl
            self.weakView = view
            return view
        }
    }
    private weak var weakView: MemberProfileViewInput?
}

extension MemberProfilePresenter: MemberProfileViewOutput {
    func memberProfile(view: MemberProfileViewInput, userDidChangeImage image: UIImage) {
        self.presenters.activity.increment()
        self.services.user.editProfile(member: member, image: image) { [weak self] (result) in
            guard let sSelf = self else { return }
            sSelf.presenters.activity.decrement()
            switch result {
            case .success(let member):
                sSelf.member = member
                sSelf.weakView?.memberImageUrl = member.imageUrl
                sSelf.output?.memberProfile(module: sSelf, didUpdate: member)
            case .failure(let error):
                sSelf.presenters.error.present(error)
            }
        }
    }
}
