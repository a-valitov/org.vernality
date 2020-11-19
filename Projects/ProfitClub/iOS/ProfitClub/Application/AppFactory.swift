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
import Main
import ActivityPresenter
import ErrorPresenter
import PCAuthentication
import PCOrganizationService
import PCUserService
import PCActionService
import ProfitClubModel
import PCCommercialOfferService

final class AppFactory {
    lazy var authentication: PCAuthentication = {
        return PCAuthenticationParseFactory().make()
    }()
    
    lazy var userService: PCUserService = {
        return PCUserServiceParse(authentication: self.authentication)
    }()
    
    func activityPresenter() -> ActivityPresenter {
        return ActivityPresenterCircleFactory().make()
    }
    
    func errorPresenter() -> ErrorPresenter {
        return ErrorPresenterAlertFactory().make()
    }
    
    func organizationService() -> PCOrganizationService {
        return PCOrganizationServiceParse()
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
    func main(output: MainModuleOutput?) -> UIViewController {
        let main = self.mainFactory.make(output: output)
        return main.view
    }
    
    func onboard(output: OnboardModuleOutput?) -> OnboardModule {
        let module = self.onboardFactory.make(output: output)
        return module
    }
    
    func review(output: ReviewModuleOutput?) -> ReviewModule {
        let module = self.reviewFactory.make(output: output)
        return module
    }
    
    func organization(_ organization: PCOrganization, output: OrganizationModuleOutput?) -> OrganizationModule {
        let module = self.organizationFactory.make(organization: organization, output: output)
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
private extension AppFactory {
    var mainFactory: MainModuleFactory {
        return MainModuleFactoryMVC()
    }
    
    var onboardFactory: OnboardFactory {
        return OnboardFactory(presenters: OnboardPresenters(error: self.errorPresenter(),
                                                            activity: self.activityPresenter()),
                              services: OnboardServices(authentication: self.authentication,
                                                        organization: self.organizationService()))
    }
    
    var reviewFactory: ReviewFactory {
        return ReviewFactory(presenters: ReviewPresenters(error: self.errorPresenter(),
                                                          activity: self.activityPresenter()),
                             services: ReviewServices(userService: self.userService))
    }
    
    var organizationFactory: OrganizationFactory {
        return OrganizationFactory(presenters: OrganizationPresenters(error: self.errorPresenter(), activity: self.activityPresenter()),
                                   services: OrganizationServices(authentication: self.authentication, organization: self.organizationService()),
                                   factories: OrganizationFactories(actions: self.actionsFactory, action: self.actionFactory, commercialOffers: self.commercialOffersFactory, commercialOffer: self.commercialOfferFactory, members: self.membersFactory))
    }
    
    var supplierFactory: SupplierFactory {
        return SupplierFactory(presenters: SupplierPresenters(error: self.errorPresenter(), activity: self.activityPresenter()),
                               services: SupplierServices(authentication: self.authentication, action: self.actionService(), commercialOffer: self.commercialOfferService()))
    }

    var memberFactory: MemberFactory {
        return MemberFactory(presenters: MemberPresenters(error: self.errorPresenter(), activity: self.activityPresenter()), services: MemberServices(action: self.actionService()))
    }

    var adminFactory: AdminFactory {
        return AdminFactory(presenters: AdminPresenters(error: self.errorPresenter(), activity: self.activityPresenter()), services: AdminServices(), factories: AdminFactories(adminOrganizations: self.adminOrganizationsFactory, adminOrganization: self.adminOrganizationFactory))
    }

    var adminOrganizationsFactory: AdminOrganizationsFactory {
        return AdminOrganizationsFactory(presenters: AdminOrganizationsPresenters(error: self.errorPresenter(), activity: self.activityPresenter()), services: AdminOrganizationsServices(organization: self.organizationService()))
    }

    var adminOrganizationFactory: AdminOrganizationFactory {
        return AdminOrganizationFactory(presenters: AdminOrganizationPresenters(error: self.errorPresenter(), activity: self.activityPresenter()), services: AdminOrganizationServices(organization: self.organizationService()))
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
        return MembersFactory(presenters: MembersPresenters(error: self.errorPresenter(), activity: self.activityPresenter()), services: MembersServices())
    }

    var memberProfileFactory: MemberProfileFactory {
        return MemberProfileFactory(presenters: MemberProfilePresenters(error: self.errorPresenter(), activity: self.activityPresenter()), services: MemberProfileServices())
    }

    var organizationProfileFactory: OrganizationProfileFactory {
        return OrganizationProfileFactory(presenters: OrganizationProfilePresenters(error: self.errorPresenter(), activity: self.activityPresenter()), services: OrganizationProfileServices())
    }

    var supplierProfileFactory: SupplierProfileFactory {
        return SupplierProfileFactory(presenters: SupplierProfilePresenters(error: self.errorPresenter(), activity: self.activityPresenter()), services: SupplierProfileServices())
    }
}
