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
import LoginView
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
        self.router?.openLogin(output: self)
    }

    // dependencies
    private let presenters: OnboardPresenters
    private let services: OnboardServices

    // persisted
    private var email: String?
    private var password: String?
    private var username: String?
    private var firstName: String?
    private var lastName: String?
    private var supplierName: String?
    private var supplierInn: String?
    private var supplierContact: String?
    private var supplierPhone: String?
}

extension OnboardPresenter: LoginViewOutput {
     func loginViewUserWantsToLogin(_ view: LoginViewInput) {
        guard let password = view.password, password.isEmpty == false else {
            self.presenters.error.present(OnboardError.passwordIsEmpty)
            return
        }
        guard let username = view.parameters?["username"] as? String, username.isEmpty == false else {
            self.presenters.error.present(OnboardError.usernameIsEmpty)
            return
        }
        self.services.authentication.login(username: username, password: password) { [weak self] result in
            guard let sSelf = self else { return }
            switch result {
            case .success(let user):
                sSelf.output?.onboard(module: sSelf, didLogin: user, inside: sSelf.router?.main)
            case .failure(let error):
                sSelf.presenters.error.present(error)
            }
        }
    }

    func loginViewUserWantsToRegister(_ view: LoginViewInput) {
        guard let email = view.email, email.isEmpty == false else {
            self.presenters.error.present(OnboardError.emailIsEmpty)
            return
        }
        guard let password = view.password, password.isEmpty == false else {
            self.presenters.error.present(OnboardError.passwordIsEmpty)
            return
        }
        guard let username = view.parameters?["username"] as? String, username.isEmpty == false else {
            self.presenters.error.present(OnboardError.usernameIsEmpty)
            return
        }
        self.email = email
        self.password = password
        self.username = username
        self.router?.openOnboardMember(output: self)
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
        self.router?.openSelectRole(output: self)
    }
}

extension OnboardPresenter: SelectRoleViewOutput {
    func selectRole(view: SelectRoleViewInput, didSelect role: PCRole) {
        switch role {
        case .member:
            self.router?.openSelectOrganization(output: self)
        case .supplier:
            self.router?.openOnboardSupplier(output: self)
        default:
            break
        }
    }
}

extension OnboardPresenter: SelectOrganizationViewOutput {
    func selectOrganization(view: SelectOrganizationViewInput, didSelect organization: AnyPCOrganization) {
        print(organization)
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
    private func registerSupplier() {
        // supplier
        guard let name = self.supplierName, name.isEmpty == false else {
            self.presenters.error.present(OnboardError.supplierNameIsEmpty)
            return
        }
        guard let inn = self.supplierInn, inn.isEmpty == false else {
            self.presenters.error.present(OnboardError.supplierInnIsEmpty)
            return
        }
        guard let contact = self.supplierContact, contact.isEmpty == false else {
            self.presenters.error.present(OnboardError.supplierContactIsEmpty)
            return
        }
        guard let phone = self.supplierPhone, phone.isEmpty == false else {
            self.presenters.error.present(OnboardError.supplierPhoneIsEmpty)
            return
        }
        var supplier = PCSupplierStruct()
        supplier.inn = inn
        supplier.contact = contact
        supplier.phone = phone
        supplier.name = name

        // member
        guard let username = self.username, username.isEmpty == false else {
            self.presenters.error.present(OnboardError.usernameIsEmpty)
            return
        }
        let member = PCMemberStruct()

        // user
        guard let email = self.email, email.isEmpty == false else {
            self.presenters.error.present(OnboardError.emailIsEmpty)
            return
        }
        guard let password = self.password, password.isEmpty == false else {
            self.presenters.error.present(OnboardError.passwordIsEmpty)
            return
        }
        var user = PCUserStruct()
        user.username = username
        user.email = email
        user.suppliers = [supplier]
        user.member = member
        
        self.services.authentication.register(user: user, password: password) { [weak self] result in
            guard let sSelf = self else { return }
            switch result {
            case .success:
                sSelf.output?.onboard(module: sSelf, didLogin: user, inside: sSelf.router?.main)
            case .failure(let error):
                sSelf.presenters.error.present(error)
            }
        }
        
    }
}
