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
import PCAuthentication
import PCModel
import PCUserService
import ErrorPresenter
import ActivityPresenter
import PCOnboard
import PCReview
import PCUserPersistence
import PCAdmin

final class AppRouter {
    var viewController: UIViewController {
        return self.navigationController
    }

    init(factory: AppFactory) {
        self.factory = factory
    }

    private let factory: AppFactory

    private var navigationController: UINavigationController {
        if let navigationController = self.weakNavigationController {
            return navigationController
        } else {
            let rootViewController: UIViewController
            if let user = self.userPersistence.user {
                rootViewController = self.reviewRouter(user: user).viewController
            } else {
                rootViewController = self.onboardRouter().viewController
            }
            let navigationController = UINavigationController(rootViewController: rootViewController)
            self.weakNavigationController = navigationController
            return navigationController
        }
    }
    private weak var weakNavigationController: UINavigationController?

    // persistence
    private lazy var userPersistence: PCUserPersistence = {
        return self.factory.userPersistence
    }()

    // presenters
    private lazy var errorPresenter: ErrorPresenter = {
        return self.factory.errorPresenter()
    }()

    private lazy var activityPresenter: ActivityPresenter = {
        return self.factory.activityPresenter()
    }()

    // routers
    private func reviewRouter(user: PCUser) -> ReviewRouter {
        if let reviewRouter = self.weakReviewRouter {
            return reviewRouter
        } else {
            let reviewRouter = ReviewRouter(user: user)
            reviewRouter.delegate = self
            self.weakReviewRouter = reviewRouter
            return reviewRouter
        }
    }
    private weak var weakReviewRouter: ReviewRouter?

    private func onboardRouter() -> OnboardRouter {
        if let onboardRouter = self.weakOnboardRouter {
            return onboardRouter
        } else {
            let onboardRouter = OnboardRouter()
            onboardRouter.delegate = self
            self.weakOnboardRouter = onboardRouter
            return onboardRouter
        }
    }
    private weak var weakOnboardRouter: OnboardRouter?
}

// MARK: - Push Notifications handling
extension AppRouter {
    func handle(push: AppPush) {
        switch push {
        case .actionCreated(let actionId):
            self.openAdminAction(actionId: actionId)
        case .commercialOfferCreated(let commercialOfferId):
            self.openAdminCommercialOffer(commercialOfferId: commercialOfferId)
        case .organizationCreated(let organizationId):
            self.openAdminOrganization(organizationId: organizationId)
        case .supplierCreated(let supplierId):
            self.openAdminSupplier(supplierId: supplierId)
        case .memberCreated(let memberId):
            self.openAdminMember(memberId: memberId)
        }
    }

    private func openAdminAction(actionId: String) {
        let actionService = self.factory.actionService()
        actionService.fetch(actionId) { [weak self] result in
            guard let sSelf = self else { return }
            switch result {
            case .success(let action):
                self?.weakReviewRouter?.route(to: action)
            case .failure(let error):
                sSelf.errorPresenter.present(error)
            }
        }
    }
    
    private func openAdminCommercialOffer(commercialOfferId: String) {
        print(commercialOfferId)
    }
    
    private func openAdminOrganization(organizationId: String) {
        print(organizationId)
    }
    
    private func openAdminSupplier(supplierId: String) {
        print(supplierId)
    }
    
    private func openAdminMember(memberId: String) {
        print(memberId)
    }
}

extension AppRouter: OnboardRouterDelegate {
    func onboard(router: OnboardRouter, didLogin user: PCUser) {
        self.navigationController.setViewControllers(
            [self.reviewRouter(user: user).viewController],
            animated: true
        )
    }

    func onboard(router: OnboardRouter, didRegister user: PCUser) {
        self.navigationController.setViewControllers(
            [self.reviewRouter(user: user).viewController],
            animated: true
        )
    }
}

extension AppRouter: ReviewRouterDelegate {
    func reviewUserDidLogout(router: ReviewRouter) {
        self.navigationController.setViewControllers(
            [self.onboardRouter().viewController],
            animated: true
        )
    }
}
