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
import Main
import ActivityPresenter
import ProfitClubModel

final class MemberProfilePresenter: MemberProfileModule {
    weak var output: MemberProfileModuleOutput?
    var router: MemberProfileRouter?

    init(member: PCMember,
         presenters: MemberProfilePresenters,
         services: MemberProfileServices) {
        self.member = member
        self.presenters = presenters
        self.services = services
    }

    func open(in main: MainModule?) {
        self.router?.main = main
        self.view = self.router?.openMemberProfile(member: self.member, output: self)
    }

    // dependencies
    private let presenters: MemberProfilePresenters
    private let services: MemberProfileServices

    // state
    private var member: PCMember
    private weak var view: MemberProfileViewInput?
}

extension MemberProfilePresenter: MemberProfileViewOutput {
    func memberProfile(view: MemberProfileViewInput, userDidChangeImage image: UIImage) {
        self.presenters.activity.increment()
        self.services.member.editProfile(member: member, image: image) { [weak self] (result) in
            guard let sSelf = self else { return }
            sSelf.presenters.activity.decrement()
            switch result {
            case .success(let member):
                sSelf.member = member
                sSelf.view?.memberImageUrl = member.imageUrl
                sSelf.output?.memberProfile(module: sSelf, didUpdate: member)
            case .failure(let error):
                sSelf.presenters.error.present(error)
            }
        }
    }
}
