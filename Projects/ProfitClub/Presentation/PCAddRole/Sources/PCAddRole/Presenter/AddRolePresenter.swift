//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Rinat Enikeev on 18.01.2021
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

import UIKit
import PCModel

final class AddRolePresenter: AddRoleModule {
    weak var output: AddRoleModuleOutput?
    var router: AnyObject?
    var viewController: UIViewController {
        return self.selectRole
    }

    init(presenters: AddRolePresenters,
         services: AddRoleServices) {
        self.presenters = presenters
        self.services = services
    }

    // dependencies
    private let presenters: AddRolePresenters
    private let services: AddRoleServices

    // views
    private var selectRole: UIViewController {
        if let selectRole = self.weakSelectRole {
            return selectRole
        } else {
            let selectRole = SelectRoleViewAlpha()
            selectRole.output = self
            self.weakSelectRole = selectRole
            return selectRole
        }
    }
    private var onboardMember: UIViewController {
        if let onboardMember = self.weakOnboardMember {
            return onboardMember
        } else {
            let onboardMember = OnboardMemberViewAlpha()
            onboardMember.output = self
            self.weakOnboardMember = onboardMember
            return onboardMember
        }
    }
    private var onboardOrganization: UIViewController {
        if let onboardOrganization = self.weakOnboardOrganization {
            return onboardOrganization
        } else {
            let onboardOrganization = OnboardOrganizationViewAlpha()
            onboardOrganization.output = self
            self.weakOnboardOrganization = onboardOrganization
            return onboardOrganization
        }
    }
    private var onboardSupplier: UIViewController {
        if let onboardSupplier = self.weakOnboardSupplier {
            return onboardSupplier
        } else {
            let onboardSupplier = OnboardSupplierViewAlpha()
            onboardSupplier.output = self
            self.weakOnboardSupplier = onboardSupplier
            return onboardSupplier
        }
    }
    private var selectOrganization: SelectOrganizationViewInput {
        if let selectOrganization = self.weakSelectOrganization {
            return selectOrganization
        } else {
            let selectOrganization = SelectOrganizationViewAlpha()
            selectOrganization.output = self
            self.weakSelectOrganization = selectOrganization
            return selectOrganization
        }
    }

    private weak var weakSelectRole: UIViewController?
    private weak var weakOnboardMember: UIViewController?
    private weak var weakOnboardOrganization: UIViewController?
    private weak var weakOnboardSupplier: UIViewController?
    private weak var weakSelectOrganization: SelectOrganizationViewInput?

    // state
    private var firstName: String?
    private var lastName: String?
    private var memberImage: UIImage?
    private var supplierName: String?
    private var supplierInn: String?
    private var supplierContact: String?
    private var supplierPhone: String?
    private var supplierImage: UIImage?
    private var organizationName: String?
    private var organizationInn: String?
    private var organizationContact: String?
    private var organizationPhone: String?
    private var organizationImage: UIImage?
}

extension AddRolePresenter: SelectRoleViewOutput {
    func selectRole(view: SelectRoleViewInput, didSelect role: PCRole) {
        guard let navigationController = view.navigationController else {
            assertionFailure("Add Role module requires navigation context")
            return
        }
        switch role {
        case .member:
            navigationController.pushViewController(self.onboardMember, animated: true)
        case .supplier:
            navigationController.pushViewController(self.onboardSupplier, animated: true)
        case .organization:
            navigationController.pushViewController(self.onboardOrganization, animated: true)
        default:
            break
        }
    }
}

extension AddRolePresenter: OnboardSupplierViewOutput {
    func onboardSupplier(view: OnboardSupplierViewInput, didFinish sender: Any) {
        guard let name = view.name, name.isEmpty == false else {
            self.presenters.error.present(AddRoleError.supplierNameIsEmpty)
            return
        }
        guard let inn = view.inn, inn.isEmpty == false else {
            self.presenters.error.present(AddRoleError.supplierInnIsEmpty)
            return
        }
        guard let contact = view.contact, contact.isEmpty == false else {
            self.presenters.error.present(AddRoleError.supplierContactIsEmpty)
            return
        }
        guard let phone = view.phone, phone.isEmpty == false else {
            self.presenters.error.present(AddRoleError.supplierPhoneIsEmpty)
            return
        }
        guard let image = view.image else {
            self.presenters.error.present(AddRoleError.supplierImageIsNil)
            return
        }
        self.supplierName = name
        self.supplierInn = inn
        self.supplierContact = contact
        self.supplierPhone = phone
        self.supplierImage = image
        self.registerSupplier()
    }
}

extension AddRolePresenter: OnboardOrganizationViewOutput {
    func onboardOrganizationDidFinish(view: OnboardOrganizationViewInput) {
        guard let name = view.name, name.isEmpty == false else {
            self.presenters.error.present(AddRoleError.organizationNameIsEmpty)
            return
        }
        guard let inn = view.inn, inn.isEmpty == false else {
            self.presenters.error.present(AddRoleError.organizationInnIsEmpty)
            return
        }
        guard let contact = view.contact, contact.isEmpty == false else {
            self.presenters.error.present(AddRoleError.organizationContactIsEmpty)
            return
        }
        guard let phone = view.phone, phone.isEmpty == false else {
            self.presenters.error.present(AddRoleError.organizationPhoneIsEmpty)
            return
        }
        guard let image = view.image else {
            self.presenters.error.present(AddRoleError.organizationImageIsNil)
            return
        }
        self.organizationName = name
        self.organizationInn = inn
        self.organizationContact = contact
        self.organizationPhone = phone
        self.organizationImage = image
        self.registerOrganization()
    }
}

extension AddRolePresenter: OnboardMemberViewOutput {
    func onboardMemberDidFinish(view: OnboardMemberViewInput) {
        guard let firstName = view.firstName, firstName.isEmpty == false else {
            self.presenters.error.present(AddRoleError.firstNameIsEmpty)
            return
        }
        guard let lastName = view.lastName, lastName.isEmpty == false else {
            self.presenters.error.present(AddRoleError.lastNameIsEmpty)
            return
        }
        guard let image = view.image else {
            self.presenters.error.present(AddRoleError.memberImageIsNil)
            return
        }
        self.firstName = firstName
        self.lastName = lastName
        self.memberImage = image

        guard let navigationController = view.navigationController else {
            assertionFailure("Add Role requires to be used in navigation context")
            return
        }

        navigationController.pushViewController(self.selectOrganization, animated: true)
        self.services.user.fetch(.approved) { [weak self] (result) in
            switch result {
            case .success(let organizations):
                self?.selectOrganization.organizations = organizations
            case .failure(let error):
                self?.presenters.error.present(error)
            }
        }
    }
}

extension AddRolePresenter: SelectOrganizationViewOutput {
    func selectOrganization(view: SelectOrganizationViewInput, userWantsToRefresh sender: Any) {
        self.presenters.activity.increment()
        self.services.user.fetch(.approved) { [weak self] (result) in
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

extension AddRolePresenter {
    private func createSupplier() -> PCSupplierStruct? {
        guard let name = self.supplierName, name.isEmpty == false else {
            self.presenters.error.present(AddRoleError.supplierNameIsEmpty)
            return nil
        }
        guard let inn = self.supplierInn, inn.isEmpty == false else {
            self.presenters.error.present(AddRoleError.supplierInnIsEmpty)
            return nil
        }
        guard let contact = self.supplierContact, contact.isEmpty == false else {
            self.presenters.error.present(AddRoleError.supplierContactIsEmpty)
            return nil
        }
        guard let phone = self.supplierPhone, phone.isEmpty == false else {
            self.presenters.error.present(AddRoleError.supplierPhoneIsEmpty)
            return nil
        }
        guard let image = self.supplierImage else {
            self.presenters.error.present(AddRoleError.supplierImageIsNil)
            return nil
        }
        var supplier = PCSupplierStruct()
        supplier.inn = inn
        supplier.contact = contact
        supplier.phone = phone
        supplier.name = name
        supplier.image = image
        supplier.status = .onReview
        return supplier
    }

    private func createMember() -> PCMemberStruct? {
        guard let firstName = self.firstName, firstName.isEmpty == false else {
            self.presenters.error.present(AddRoleError.firstNameIsEmpty)
            return nil
        }
        guard let lastName = self.lastName, lastName.isEmpty == false else {
            self.presenters.error.present(AddRoleError.lastNameIsEmpty)
            return nil
        }
        guard let image = self.memberImage else {
            self.presenters.error.present(AddRoleError.memberImageIsNil)
            return nil
        }
        var member = PCMemberStruct()
        member.firstName = self.firstName
        member.lastName = self.lastName
        member.image = image
        member.status = .onReview
        return member
    }

    private func createOrganization() -> PCOrganizationStruct? {
        guard let name = self.organizationName, name.isEmpty == false else {
            self.presenters.error.present(AddRoleError.organizationNameIsEmpty)
            return nil
        }
        guard let inn = self.organizationInn, inn.isEmpty == false else {
            self.presenters.error.present(AddRoleError.organizationInnIsEmpty)
            return nil
        }
        guard let contact = self.organizationContact, contact.isEmpty == false else {
            self.presenters.error.present(AddRoleError.organizationContactIsEmpty)
            return nil
        }
        guard let phone = self.organizationPhone, phone.isEmpty == false else {
            self.presenters.error.present(AddRoleError.organizationPhoneIsEmpty)
            return nil
        }
        guard let image = self.organizationImage else {
            self.presenters.error.present(AddRoleError.organizationImageIsNil)
            return nil
        }
        var organization = PCOrganizationStruct()
        organization.name = name
        organization.inn = inn
        organization.contact = contact
        organization.phone = phone
        organization.image = image
        organization.status = .onReview
        return organization
    }

    private func registerMember(in organization: PCOrganization) {
        guard let member = self.createMember() else {
            return
        }
        self.presenters.activity.increment()
        self.services.user.add(member: member, in: organization) { [weak self] (result) in
            guard let sSelf = self else { return }
            sSelf.presenters.activity.decrement()
            switch result {
            case .success:
                sSelf.presenters.confirmation.present(
                    title: "Ваши данные отправлены в обработку",
                    message: "Дождитесь, пока работодатель одобрит вашу заявку на вступление в клуб",
                    actionTitle: "Спасибо",
                    withCancelAction: false
                ) { [weak sSelf] in
                    guard let ssSelf = sSelf else { return }
                    ssSelf.output?.addRole(module: ssSelf, didAddMember: member)
                }
            case .failure(let error):
                sSelf.presenters.error.present(error)
            }
        }
    }

    private func registerOrganization() {
        guard let organization = self.createOrganization() else {
            return
        }
        self.presenters.activity.increment()
        self.services.user.add(organization: organization) { [weak self] (result) in
            guard let sSelf = self else { return }
            sSelf.presenters.activity.decrement()
            switch result {
            case .success:
                sSelf.presenters.confirmation.present(
                    title: "Ваши данные отправлены в обработку",
                    message: "Дождитесь, пока администратор одобрит вашу заявку на вступление в клуб",
                    actionTitle: "Спасибо",
                    withCancelAction: false
                ) { [weak sSelf] in
                    guard let ssSelf = sSelf else { return }
                    ssSelf.output?.addRole(module: ssSelf, didAddOrganization: organization)
                }
            case .failure(let error):
                sSelf.presenters.error.present(error)
            }
        }
    }

    private func registerSupplier() {
        guard let supplier = self.createSupplier() else {
            return
        }
        self.presenters.activity.increment()
        self.services.user.add(supplier: supplier) { [weak self] result in
            guard let sSelf = self else { return }
            sSelf.presenters.activity.decrement()
            switch result {
            case .success:
                sSelf.presenters.confirmation.present(
                    title: "Ваши данные отправлены в обработку",
                    message: "Дождитесь, пока администратор одобрит вашу заявку на вступление в клуб",
                    actionTitle: "Спасибо",
                    withCancelAction: false
                ) { [weak sSelf] in
                    guard let ssSelf = sSelf else { return }
                    ssSelf.output?.addRole(module: ssSelf, didAddSupplier: supplier)
                }
            case .failure(let error):
                sSelf.presenters.error.present(error)
            }
        }
    }
}
