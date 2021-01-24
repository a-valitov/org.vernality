//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/24/20
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
import ErrorPresenter
import PCAuthentication
import PCOrganizationService
import PCUserService
import PCActionService
import PCModel
import PCCommercialOfferService
import ConfirmationPresenter
import PCSupplierService
import MenuPresenter
import PCOnboard
import PCReview
import PCUserPersistence

final class AppFactory {
    lazy var authentication: PCAuthentication = {
        return PCAuthenticationParseFactory().make()
    }()

    lazy var userService: PCUserService = {
        return PCUserServiceParseFactory(user: PCUserStruct()).make()
    }()

    lazy var userPersistence: PCUserPersistence = {
        return PCUserPersistenceParseFactory().make()
    }()
    
    func activityPresenter() -> ActivityPresenter {
        return ActivityPresenterCircleFactory().make()
    }
    
    func errorPresenter() -> ErrorPresenter {
        return ErrorPresenterAlertFactory().make()
    }

    func confirmationPresenter() -> ConfirmationPresenter {
        return ConfirmationPresenterAlertFactory().make()
    }

    func menuPresenter() -> MenuPresenter {
        return MenuPresenterActionSheetFactory().make()
    }
    
    func organizationService() -> PCOrganizationService {
        return PCOrganizationServiceParse()
    }

    func supplierService() -> PCSupplierService {
        return PCSupplierServiceParse()
    }

    func actionService() -> PCActionService {
        return PCActionServiceParse()
    }

    func commercialOfferService() -> PCCommercialOfferService {
        return PCCommercialOfferServiceParse()
    }
}

// MARK: - ViewContollers
extension AppFactory {
    func onboard(output: OnboardModuleOutput?) -> OnboardModule {
        let module = self.onboardFactory.make(output: output)
        return module
    }

    func supplier(supplier: PCSupplier, output: SupplierModuleOutput?) -> SupplierModule {
        let module = self.supplierFactory.make(supplier: supplier, output: output)
        return module
    }

    func member(member: PCMember, output: MemberModuleOutput?) -> MemberModule {
        let module = self.memberFactory.make(member: member, output: output)
        return module
    }

    func memberProfile(member: PCMember, output: MemberProfileModuleOutput?) -> MemberProfileModule {
        let module = self.memberProfileFactory.make(member: member, output: output)
        return module
    }

    func organizationProfile(organization: PCOrganization, output: OrganizationProfileModuleOutput?) -> OrganizationProfileModule {
        let module = self.organizationProfileFactory.make(organization: organization, output: output)
        return module
    }

    func supplierProfile(supplier: PCSupplier, output: SupplierProfileModuleOutput?) -> SupplierProfileModule {
        let module = self.supplierProfileFactory.make(supplier: supplier, output: output)
        return module
    }
}

// MARK: - Factories
extension AppFactory {
    var onboardFactory: OnboardFactory {
        return OnboardFactory(
            presenters: OnboardPresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter(),
                confirmation: self.confirmationPresenter()),
            services: OnboardServices(
                authentication: self.authentication
            )
        )
    }
    
    var supplierFactory: SupplierFactory {
        return SupplierFactory(presenters: SupplierPresenters(error: self.errorPresenter(), activity: self.activityPresenter(), confirmation: self.confirmationPresenter(), menu: self.menuPresenter()),
                               services: SupplierServices(authentication: self.authentication, action: self.actionService(), commercialOffer: self.commercialOfferService()))
    }

    var memberFactory: MemberFactory {
        return MemberFactory(presenters: MemberPresenters(error: self.errorPresenter(), activity: self.activityPresenter(), confirmation: self.confirmationPresenter(), menu: self.menuPresenter()), services: MemberServices(action: self.actionService()))
    }

    var actionsFactory: ActionsFactory {
        return ActionsFactory(presenters: ActionsPresenters(error: self.errorPresenter(), activity: self.activityPresenter()),
                              services: ActionsServices(action: self.actionService()))
    }

    var actionFactory: ActionFactory {
        return ActionFactory(presenters: ActionPresenters(error: self.errorPresenter(), activity: self.activityPresenter()),
                             services: ActionServices(action: self.actionService()))
    }

    var commercialOffersFactory: CommercialOffersFactory {
        return CommercialOffersFactory(presenters: CommercialOffersPresenters(error: self.errorPresenter(), activity: self.activityPresenter()), services: CommercialOffersServices(commercialOffer: self.commercialOfferService()))
    }

    var commercialOfferFactory: CommercialOfferFactory {
        return CommercialOfferFactory(presenters: CommercialOfferPresenters(error: self.errorPresenter(), activity: self.activityPresenter()), services: CommercialOfferServices(commercialOffer: self.commercialOfferService()))
    }

    var membersFactory: MembersFactory {
        return MembersFactory(presenters: MembersPresenters(error: self.errorPresenter(), activity: self.activityPresenter(), confirmation: self.confirmationPresenter()), services: MembersServices(organization: self.organizationService()))
    }

    var memberProfileFactory: MemberProfileFactory {
        return MemberProfileFactory(presenters: MemberProfilePresenters(error: self.errorPresenter(), activity: self.activityPresenter()), services: MemberProfileServices(member: self.userService))
    }

    var organizationProfileFactory: OrganizationProfileFactory {
        return OrganizationProfileFactory(presenters: OrganizationProfilePresenters(error: self.errorPresenter(), activity: self.activityPresenter()), services: OrganizationProfileServices(organization: self.organizationService()))
    }

    var supplierProfileFactory: SupplierProfileFactory {
        return SupplierProfileFactory(presenters: SupplierProfilePresenters(error: self.errorPresenter(), activity: self.activityPresenter()), services: SupplierProfileServices(supplier: self.supplierService()))
    }

    var addRoleFactory: AddRoleFactory {
        return AddRoleFactory(
            presenters: AddRolePresenters(
                error: self.errorPresenter(),
                activity: self.activityPresenter(),
                confirmation: self.confirmationPresenter()
            ),
            services: AddRoleServices(
                user: self.userService,
                organization: self.organizationService()
            )
        )
    }
}
