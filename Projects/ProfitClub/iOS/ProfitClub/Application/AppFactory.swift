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
    
    func organization(output: OrganizationModuleOutput?) -> OrganizationModule {
        let module = self.organizationFactory.make(output: output)
        return module
    }
    
    func supplier(supplier: PCSupplier, output: SupplierModuleOutput?) -> SupplierModule {
        let module = self.supplierFactory.make(supplier: supplier, output: output)
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
                                   factories: OrganizationFactories(actions: self.actionsFactory, action: self.actionFactory))
    }
    
    var supplierFactory: SupplierFactory {
        return SupplierFactory(presenters: SupplierPresenters(error: self.errorPresenter(), activity: self.activityPresenter()),
                               services: SupplierServices(authentication: self.authentication, action: self.actionService(), commercialOffer: self.commercialOfferService()))
    }

    var actionsFactory: ActionsFactory {
        return ActionsFactory(presenters: ActionsPresenters(error: self.errorPresenter(), activity: self.activityPresenter()),
                              services: ActionsServices(action: self.actionService()))
    }

    var actionFactory: ActionFactory {
        return ActionFactory(presenters: ActionPresenters(error: self.errorPresenter(), activity: self.activityPresenter()),
                             services: ActionServices(action: self.actionService()))
    }
}
