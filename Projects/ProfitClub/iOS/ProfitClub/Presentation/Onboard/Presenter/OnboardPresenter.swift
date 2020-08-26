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

    init(presenters: OnboardPresenters) {
        self.presenters = presenters
    }

    func start(in main: MainModule?) {
        self.router?.main = main
        self.router?.openLogin(output: self)
    }

    private let presenters: OnboardPresenters

    // persisted
    private var email: String?
    private var password: String?
    private var username: String?
    private var supplierName: String?
    private var supplierInn: String?
    private var supplierContact: String?
    private var supplierPhone: String?
    private var role: PCRole?
}

extension OnboardPresenter: LoginViewOutput {
     func loginViewUserWantsToLogin(_ view: LoginViewInput) {
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
        self.router?.openSelectRole(output: self)
    }
}

extension OnboardPresenter: SelectRoleViewOutput {
    func selectRole(view: SelectRoleViewInput, didSelect role: PCRole) {
        self.role = role
        switch role {
        case .member:
            break
        case .organization:
            break
        case .supplier:
            self.router?.openOnboardSupplier(output: self)
        case .administratior:
            break
        }
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
    }
}

extension OnboardPresenter {
    private func registerSupplier() {
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
        let supplier = PCSupplierStruct(name: name, inn: inn, contact: contact, phone: phone)

        guard let email = self.email, email.isEmpty == false else {
            self.presenters.error.present(OnboardError.emailIsEmpty)
            return
        }
        guard let password = self.password, password.isEmpty == false else {
            self.presenters.error.present(OnboardError.passwordIsEmpty)
            return
        }
        guard let username = self.username, username.isEmpty == false else {
            self.presenters.error.present(OnboardError.usernameIsEmpty)
            return
        }

        var user = PCUserStruct(roles: [.supplier])
        user.supplier = supplier
        user.username = username
        user.email = email
        
    }
}
