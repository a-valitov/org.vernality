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
import ProfitClubModel

final class OnboardRouter {
    weak var main: MainModule?

    @discardableResult
    func openOnboardWelcome(output: OnboardWelcomeViewOutput?) -> OnboardWelcomeViewInput {
        let storyboard = UIStoryboard(name: "OnboardWelcomeViewBeta", bundle: nil)
        let onboardWelcome = storyboard.instantiateInitialViewController() as! OnboardWelcomeViewBeta
        onboardWelcome.output = output
        self.main?.push(onboardWelcome, animated: false)
        return onboardWelcome
    }

    @discardableResult
    func openOnboardSignIn(output: OnboardSignInViewOutput?) -> OnboardSignInViewInput {
        let storyboard = UIStoryboard(name: "OnboardSignInViewBeta", bundle: nil)
        let onboardSignIn = storyboard.instantiateInitialViewController() as! OnboardSignInViewBeta
        onboardSignIn.output = output
        self.main?.raise(onboardSignIn, animated: true)
        return onboardSignIn
    }

    @discardableResult
    func openOnboardSignUp(output: OnboardSignUpViewOutput?) -> OnboardSignUpViewInput {
        let storyboard = UIStoryboard(name: "OnboardSignUpViewBeta", bundle: nil)
        let onboardSignUp = storyboard.instantiateInitialViewController() as! OnboardSignUpViewBeta
        onboardSignUp.output = output
        self.main?.raise(onboardSignUp, animated: true)
        return onboardSignUp
    }

    @discardableResult
    func openSelectRole(output: SelectRoleViewOutput?) -> SelectRoleViewInput {
        let storyboard = UIStoryboard(name: "SelectRoleViewBeta", bundle: nil)
        let selectRoleView = storyboard.instantiateInitialViewController() as! SelectRoleViewBeta
        selectRoleView.output = output
        self.main?.push(selectRoleView, animated: true)
        return selectRoleView
    }

    @discardableResult
    func openOnboardMember(output: OnboardMemberViewOutput?) -> OnboardMemberViewInput {
        let storyboard = UIStoryboard(name: "OnboardMemberViewBeta", bundle: nil)
        let onboardMember = storyboard.instantiateInitialViewController() as! OnboardMemberViewBeta
        onboardMember.output = output
        self.main?.push(onboardMember, animated: true)
        return onboardMember
    }

    @discardableResult
    func openSelectOrganization(output: SelectOrganizationViewOutput?) -> SelectOrganizationViewInput {
        let storyboard = UIStoryboard(name: "SelectOrganizationViewBeta", bundle: nil)
        let selectOrganization = storyboard.instantiateInitialViewController() as! SelectOrganizationViewBeta
        selectOrganization.output = output
        self.main?.push(selectOrganization, animated: true)
        return selectOrganization
    }

    @discardableResult func openOnboardOrganization(output: OnboardOrganizationViewOutput?) -> OnboardOrganizationViewInput {
        let storyboard = UIStoryboard(name: "OnboardOrganizationViewBeta", bundle: nil)
        let onboardOrganization = storyboard.instantiateInitialViewController() as! OnboardOrganizationViewBeta
        onboardOrganization.output = output
        self.main?.push(onboardOrganization, animated: true)
        return onboardOrganization
    }

    @discardableResult
    func openOnboardSupplier(output: OnboardSupplierViewOutput?) -> OnboardSupplierViewInput {
        let onboardSupplier = OnboardSupplierViewAlpha()
        onboardSupplier.output = output
        self.main?.push(onboardSupplier, animated: true)
        return onboardSupplier
    }
}
