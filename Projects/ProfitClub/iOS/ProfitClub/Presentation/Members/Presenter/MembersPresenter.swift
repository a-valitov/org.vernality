//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 02.11.2020
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

final class MembersPresenter: MembersModule {
    weak var output: MembersModuleOutput?
    var router: MembersRouter?

    init(organization: PCOrganization,
        presenters: MembersPresenters,
        services: MembersServices) {
        self.organization = organization
        self.presenters = presenters
        self.services = services
    }

    func embed(in tabBarController: UITabBarController, main: MainModule?) {
        self.router?.main = main
        self.router?.embed(in: tabBarController, output: self)
    }

    private let organization: PCOrganization

    // dependencies
    private let presenters: MembersPresenters
    private let services: MembersServices

    // submodules
    private weak var membersOfOrganization: MembersOfOrganizationViewInput?
}

extension MembersPresenter: MembersContainerViewOutput {
    func membersContainerDidLoad(view: MembersContainerViewInput) {
        view.membersOfOrganization = router?.buildMembersOfOrganization(output: self)
        view.applications = router?.buildApplications(output: self)
    }

    func membersContainer(view: MembersContainerViewInput, didChangeState state: MembersContainerState) {
        view.state = state
    }
}

extension MembersPresenter: MembersOfOrganizationViewOutput {
    func membersOfOrganizationDidLoad(view: MembersOfOrganizationViewInput) {
        self.membersOfOrganization = view
        self.reloadMembersOfOrganization()
    }

    func membersOfOrganization(view: MembersOfOrganizationViewInput, userWantsToRefresh sender: Any) {
        self.membersOfOrganization = view
        self.reloadMembersOfOrganization()
    }

}

extension MembersPresenter: ApplicationsViewOutput {
    func applicationsDidLoad(view: ApplicationsViewInput) {
        self.services.organization.fetchApprovedApplications(organization) { [weak self] (result) in
            switch result {
            case .success(let members):
                view.members = members
                view.reload()
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }

    func applications(view: ApplicationsViewInput, userWantsToRefresh sender: Any) {
        self.services.organization.fetchApprovedApplications(organization) { [weak self] (result) in
            switch result {
            case .success(let members):
                view.members = members
                view.reload()
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }

    func applications(view: ApplicationsViewInput, userWantsToApprove member: PCMember) {
        self.presenters.confirmation.present(title: "Одобрить заявку?", message: "Одобрить заявку на вступление \(member.firstName!) \(member.lastName!) в организацию?", actionTitle: "Одобрить", withCancelAction: true) {
            self.services.organization.approve(member: member) { [weak self] result in
                switch result {
                case .success(let member):
                    view.hide(member: member)
                    self?.reloadMembersOfOrganization()
                case .failure(let error):
                    self?.presenters.error.present(error)
                }
            }
        }
    }

    func applications(view: ApplicationsViewInput, userWantsToReject member: PCMember) {
        self.presenters.confirmation.present(title: "Отклонить заявку?", message: "Отклонить заявку на вступление \(member.firstName!) \(member.lastName!) в организацию?", actionTitle: "Отклонить", withCancelAction: true) {
            self.services.organization.reject(member: member) { [weak self] result in
                switch result {
                case .success(let member):
                    view.hide(member: member)
                case .failure(let error):
                    self?.presenters.error.present(error)
                }
            }
        }
    }
}

extension MembersPresenter {
    private func reloadMembersOfOrganization() {
        self.services.organization.fetchApprovedMembersOfOrganization(organization) { [weak self] (result) in
                switch result {
                case .success(let members):
                    self?.membersOfOrganization?.members = members
                case .failure(let error):
                    self?.presenters.error.present(error)
                }
        }
    }
}

