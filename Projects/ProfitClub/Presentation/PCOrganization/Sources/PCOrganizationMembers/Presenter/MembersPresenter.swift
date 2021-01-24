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
import UIKit
import ErrorPresenter
import ActivityPresenter
import ConfirmationPresenter
import PCModel

final class MembersPresenter: MembersModule {
    weak var output: MembersModuleOutput?
    var viewController: UIViewController {
        return self.container
    }

    init(organization: PCOrganization,
        presenters: MembersPresenters,
        services: MembersServices) {
        self.organization = organization
        self.presenters = presenters
        self.services = services
    }
    
    private let organization: PCOrganization

    // dependencies
    private let presenters: MembersPresenters
    private let services: MembersServices

    // submodules
    private var container: UIViewController {
        if let container = self.weakContainer {
            return container
        } else {
            let container = MembersContainerViewAlpha()
            container.output = self
            self.weakContainer = container
            return container
        }
    }
    private var applications: UIViewController {
        if let applications = self.weakApplications {
            return applications
        } else {
            let applications = ApplicationsViewAlpha()
            applications.output = self
            self.weakApplications = applications
            return applications
        }
    }
    private var members: UIViewController {
        if let members = self.weakMembers {
            return members
        } else {
            let members = MembersOfOrganizationViewAlpha()
            members.output = self
            self.weakMembers = members
            return members
        }
    }

    private weak var weakContainer: UIViewController?
    private weak var weakApplications: UIViewController?
    private weak var weakMembers: MembersOfOrganizationViewInput?
}

extension MembersPresenter: MembersContainerViewOutput {
    func membersContainerDidLoad(view: MembersContainerViewInput) {
        view.membersOfOrganization = self.members
        view.applications = self.applications
    }

    func membersContainer(view: MembersContainerViewInput, didChangeState state: MembersContainerState) {
        view.state = state
    }
}

extension MembersPresenter: MembersOfOrganizationViewOutput {
    func membersOfOrganizationDidLoad(view: MembersOfOrganizationViewInput) {
        self.reloadMembersOfOrganization()
    }

    func membersOfOrganization(view: MembersOfOrganizationViewInput, userWantsToRefresh sender: Any) {
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
                    self?.weakMembers?.members = members
                case .failure(let error):
                    self?.presenters.error.present(error)
                }
        }
    }
}

