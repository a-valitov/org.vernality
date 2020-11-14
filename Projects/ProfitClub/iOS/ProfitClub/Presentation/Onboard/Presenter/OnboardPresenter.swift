//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/26/20
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

final class OnboardPresenter: OnboardModule {
    weak var output: OnboardModuleOutput?
    var router: OnboardRouter?

    init(presenters: OnboardPresenters,
         services: OnboardServices) {
        self.presenters = presenters
        self.services = services
    }

    func start(in main: MainModule?) {
        self.router?.main = main
        self.router?.openOnboardWelcome(output: self)
    }

    func onboard(in main: MainModule?) {
        self.router?.main = main
        self.router?.openSelectRole(output: self)
    }

    // dependencies
    private let presenters: OnboardPresenters
    private let services: OnboardServices

    // persisted
    private var email: String?
    private var password: String?
    private var firstName: String?
    private var lastName: String?
    private var supplierName: String?
    private var supplierInn: String?
    private var supplierContact: String?
    private var supplierPhone: String?
    private var organizationName: String?
    private var organizationInn: String?
    private var organizationContact: String?
    private var organizationPhone: String?
}

extension OnboardPresenter: OnboardWelcomeViewOutput {
    func onboardWelcome(view: OnboardWelcomeViewInput, userWantsToSignIn sender: Any) {
        self.router?.openOnboardSignIn(output: self)
    }

    func onboardWelcome(view: OnboardWelcomeViewInput, userWantsToSignUp sender: Any) {
        self.router?.openOnboardSignUp(output: self)
    }
}

extension OnboardPresenter: OnboardSignInViewOutput {
    func onboardSignIn(view: OnboardSignInViewInput, userWantsToSignIn sender: Any) {
        guard let password = view.password, password.isEmpty == false else {
            self.presenters.error.present(OnboardError.passwordIsEmpty)
            return
        }
        guard let username = view.username, username.isEmpty == false else {
            self.presenters.error.present(OnboardError.usernameIsEmpty)
            return
        }
        self.presenters.activity.increment()
        self.services.authentication.login(username: username, password: password) { [weak self] result in
            guard let sSelf = self else { return }
            sSelf.presenters.activity.decrement()
            switch result {
            case .success(let user):
                sSelf.router?.main?.unraise(animated: true, completion: { [weak sSelf] in
                    guard let ssSelf = sSelf else { return }
                    ssSelf.output?.onboard(module: ssSelf, didLogin: user, inside: ssSelf.router?.main)
                })

            case .failure(let error):
                sSelf.presenters.error.present(error)
            }
        }
    }

    func onboardSingUp(view: OnboardSignInViewInput, userWantsToSignUp sender: Any) {
        self.router?.main?.unraise(animated: true, completion: { [weak self] in
            self?.router?.openOnboardSignUp(output: self)
        })
    }

    func onboardResetPassword(view: OnboardSignInViewInput, userWantsToResetPassword sender: Any) {
        self.router?.main?.unraise(animated: true, completion: { [weak self] in
            self?.router?.openResetPassword(output: self)
        })
    }
}

extension OnboardPresenter: OnboardSignUpViewOutput {
    func onboardSignUp(view: OnboardSignUpViewInput, userWantsToSignUp sender: Any) {
        guard let email = view.email, email.isEmpty == false else {
            self.presenters.error.present(OnboardError.emailIsEmpty)
            return
        }
        guard let password = view.password, password.isEmpty == false else {
            self.presenters.error.present(OnboardError.passwordIsEmpty)
            return
        }
        guard let passwordConfirmation = view.passwordConfirmation, passwordConfirmation.isEmpty == false else {
            self.presenters.error.present(OnboardError.passwordIsEmpty)
            return
        }
        guard password == passwordConfirmation else {
            self.presenters.error.present(OnboardError.passwordNotMatchConfirmation)
            return
        }
        self.email = email
        self.password = password
        self.router?.main?.unraise(animated: true, completion: { [weak self] in
            self?.router?.openSelectRole(output: self)
        })
    }

    func onboardSignIn(view: OnboardSignUpViewInput, userWantsToSignIp sender: Any) {
        self.router?.main?.unraise(animated: true, completion: { [weak self] in
            self?.router?.openOnboardSignIn(output: self)
        })
    }
}

extension OnboardPresenter: OnboardResetPasswordViewOutput {
    func onboardResetPasswordDidFinish(view: OnboardResetPasswordViewInput) {
        guard let email = view.email, email.isEmpty == false else {
            self.presenters.error.present(OnboardError.emailIsEmpty)
            return
        }

    }

}

extension OnboardPresenter: OnboardMemberViewOutput {
    func onboardMemberDidFinish(view: OnboardMemberViewInput) {
        guard let firstName = view.firstName, firstName.isEmpty == false else {
            self.presenters.error.present(OnboardError.firstNameIsEmpty)
            return
        }
        guard let lastName = view.lastName, lastName.isEmpty == false else {
            self.presenters.error.present(OnboardError.lastNameIsEmpty)
            return
        }
        self.firstName = firstName
        self.lastName = lastName
        let selectOrganization = self.router?.openSelectOrganization(output: self)
        self.services.organization.fetchApproved { [weak self] (result) in
            switch result {
            case .success(let organizations):
                selectOrganization?.organizations = organizations
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }
}

extension OnboardPresenter: SelectRoleViewOutput {
    func selectRole(view: SelectRoleViewInput, didSelect role: PCRole) {
        switch role {
        case .member:
            self.router?.openOnboardMember(output: self)
        case .supplier:
            self.router?.openOnboardSupplier(output: self)
        case .organization:
            self.router?.openOnboardOrganization(output: self)
        default:
            break
        }
    }
}

extension OnboardPresenter: OnboardOrganizationViewOutput {
    func onboardOrganizationDidFinish(view: OnboardOrganizationViewInput) {
        guard let name = view.name, name.isEmpty == false else {
            self.presenters.error.present(OnboardError.organizationNameIsEmpty)
            return
        }
        guard let inn = view.inn, inn.isEmpty == false else {
            self.presenters.error.present(OnboardError.organizationInnIsEmpty)
            return
        }
        guard let contact = view.contact, contact.isEmpty == false else {
            self.presenters.error.present(OnboardError.organizationContactIsEmpty)
            return
        }
        guard let phone = view.phone, phone.isEmpty == false else {
            self.presenters.error.present(OnboardError.organizationPhoneIsEmpty)
            return
        }
        self.organizationName = name
        self.organizationInn = inn
        self.organizationContact = contact
        self.organizationPhone = phone
        self.registerOrganization()
    }
}

extension OnboardPresenter: SelectOrganizationViewOutput {
    func selectOrganization(view: SelectOrganizationViewInput, userWantsToRefresh sender: Any) {
        self.presenters.activity.increment()
        self.services.organization.fetchApproved { [weak self] (result) in
            self?.presenters.activity.decrement()
            switch result {
            case .success(let organizations):
                view.organizations = organizations
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }

    func selectOrganization(view: SelectOrganizationViewInput, didSelect organization: AnyPCOrganization) {
        self.registerMember(in: organization)
    }
}

extension OnboardPresenter: OnboardSupplierViewOutput {
    func onboardSupplier(view: OnboardSupplierViewInput, didFinish sender: Any) {
        guard let name = view.name, name.isEmpty == false else {
            self.presenters.error.present(OnboardError.supplierNameIsEmpty)
            return
        }
        guard let inn = view.inn, inn.isEmpty == false else {
            self.presenters.error.present(OnboardError.supplierInnIsEmpty)
            return
        }
        guard let contact = view.contact, contact.isEmpty == false else {
            self.presenters.error.present(OnboardError.supplierContactIsEmpty)
            return
        }
        guard let phone = view.phone, phone.isEmpty == false else {
            self.presenters.error.present(OnboardError.supplierPhoneIsEmpty)
            return
        }
        self.supplierName = name
        self.supplierInn = inn
        self.supplierContact = contact
        self.supplierPhone = phone
        self.registerSupplier()
    }
}

extension OnboardPresenter {
    private func createUser() -> PCUserStruct? {
        guard let email = self.email, email.isEmpty == false else {
            return nil
        }
        var user = PCUserStruct()
        user.username = email
        user.email = email
        return user
    }

    private func createSupplier() -> PCSupplierStruct? {
        guard let name = self.supplierName, name.isEmpty == false else {
            self.presenters.error.present(OnboardError.supplierNameIsEmpty)
            return nil
        }
        guard let inn = self.supplierInn, inn.isEmpty == false else {
            self.presenters.error.present(OnboardError.supplierInnIsEmpty)
            return nil
        }
        guard let contact = self.supplierContact, contact.isEmpty == false else {
            self.presenters.error.present(OnboardError.supplierContactIsEmpty)
            return nil
        }
        guard let phone = self.supplierPhone, phone.isEmpty == false else {
            self.presenters.error.present(OnboardError.supplierPhoneIsEmpty)
            return nil
        }
        var supplier = PCSupplierStruct()
        supplier.inn = inn
        supplier.contact = contact
        supplier.phone = phone
        supplier.name = name
        supplier.status = .onReview
        return supplier
    }

    private func createMember() -> PCMemberStruct? {
        guard let firstName = self.firstName, firstName.isEmpty == false else {
            self.presenters.error.present(OnboardError.firstNameIsEmpty)
            return nil
        }
        guard let lastName = self.lastName, lastName.isEmpty == false else {
            self.presenters.error.present(OnboardError.lastNameIsEmpty)
            return nil
        }
        var member = PCMemberStruct()
        member.firstName = self.firstName
        member.lastName = self.lastName
        member.status = .onReview
        return member
    }

    private func createOrganization() -> PCOrganizationStruct? {
        guard let name = self.organizationName, name.isEmpty == false else {
            self.presenters.error.present(OnboardError.organizationNameIsEmpty)
            return nil
        }
        guard let inn = self.organizationInn, inn.isEmpty == false else {
            self.presenters.error.present(OnboardError.organizationInnIsEmpty)
            return nil
        }
        guard let contact = self.organizationContact, contact.isEmpty == false else {
            self.presenters.error.present(OnboardError.organizationContactIsEmpty)
            return nil
        }
        guard let phone = self.organizationPhone, phone.isEmpty == false else {
            self.presenters.error.present(OnboardError.organizationPhoneIsEmpty)
            return nil
        }
        var organization = PCOrganizationStruct()
        organization.name = name
        organization.inn = inn
        organization.contact = contact
        organization.phone = phone
        organization.status = .onReview
        return organization
    }

    private func registerMember(in organization: PCOrganization) {
        guard let member = self.createMember() else {
            return
        }

        if var user = self.createUser() {
            guard let password = self.password, password.isEmpty == false else {
                self.presenters.error.present(OnboardError.passwordIsEmpty)
                return
            }

            self.presenters.activity.increment()
            self.services.authentication.register(user: user, password: password) { [weak self] result in
                guard let sSelf = self else { return }
                sSelf.presenters.activity.decrement()
                switch result {
                case .success:
                    sSelf.services.authentication.add(member: member, in: organization) { [weak sSelf] (result) in
                        guard let ssSelf = sSelf else { return }
                        switch result {
                        case .success:
                            ssSelf.output?.onboard(module: ssSelf, didRegister: user, inside: ssSelf.router?.main)
                        case .failure(let error):
                            ssSelf.presenters.error.present(error)
                        }
                    }

                case .failure(let error):
                    sSelf.presenters.error.present(error)
                }
            }
        } else {
            self.presenters.activity.increment()
            self.services.authentication.add(member: member, in: organization) { [weak self] (result) in
                guard let sSelf = self else { return }
                sSelf.presenters.activity.decrement()
                switch result {
                case .success:
                    sSelf.output?.onboard(module: sSelf, didAddMember: member, inside: sSelf.router?.main)
                case .failure(let error):
                    sSelf.presenters.error.present(error)
                }
            }
        }
    }

    private func registerOrganization() {
        guard let organization = self.createOrganization() else {
            return
        }
        if var user = self.createUser() {
            guard let password = self.password, password.isEmpty == false else {
                self.presenters.error.present(OnboardError.passwordIsEmpty)
                return
            }

            self.presenters.activity.increment()
            self.services.authentication.register(user: user, password: password) { [weak self] result in
                guard let sSelf = self else { return }
                switch result {
                case .success:
                    sSelf.services.authentication.add(organization: organization) { [weak sSelf] (result) in
                        guard let ssSelf = sSelf else { return }
                        ssSelf.presenters.activity.decrement()
                        switch result {
                        case .success:
                            ssSelf.output?.onboard(module: ssSelf, didRegister: user, inside: ssSelf.router?.main)
                        case .failure(let error):
                            ssSelf.presenters.error.present(error)
                        }
                    }
                case .failure(let error):
                    sSelf.presenters.error.present(error)
                }
            }
        } else {
            self.presenters.activity.increment()
            self.services.authentication.add(organization: organization) { [weak self] (result) in
                guard let sSelf = self else { return }
                sSelf.presenters.activity.decrement()
                switch result {
                case .success:
                    sSelf.output?.onboard(module: sSelf, didAddOrganization: organization, inside: sSelf.router?.main)
                case .failure(let error):
                    sSelf.presenters.error.present(error)
                }
            }
        }
    }

    private func registerSupplier() {
        guard let supplier = self.createSupplier() else {
            return
        }

        if let user = self.createUser() {
            guard let password = self.password, password.isEmpty == false else {
                self.presenters.error.present(OnboardError.passwordIsEmpty)
                return
            }
            self.presenters.activity.increment()
            self.services.authentication.register(user: user, password: password) { [weak self] result in
                guard let sSelf = self else { return }
                switch result {
                case .success:
                    sSelf.services.authentication.add(supplier: supplier) { [weak sSelf] (result) in
                        guard let ssSelf = sSelf else { return }
                        ssSelf.presenters.activity.decrement()
                        switch result {
                        case .success:
                            ssSelf.output?.onboard(module: ssSelf, didLogin: user, inside: ssSelf.router?.main)
                        case .failure(let error):
                            ssSelf.presenters.error.present(error)
                        }
                    }

                case .failure(let error):
                    sSelf.presenters.error.present(error)
                }
            }
        } else {
            self.presenters.activity.increment()
            self.services.authentication.add(supplier: supplier) { [weak self] result in
                guard let sSelf = self else { return }
                sSelf.presenters.activity.decrement()
                switch result {
                case .success:
                    sSelf.output?.onboard(module: sSelf, didAddSupplier: supplier, inside: sSelf.router?.main)
                case .failure(let error):
                    sSelf.presenters.error.present(error)
                }
            }
        }
    }
}
