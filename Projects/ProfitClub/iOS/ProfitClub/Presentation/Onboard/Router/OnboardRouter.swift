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
        let onboardWelcome = OnboardWelcomeViewAlpha()
        onboardWelcome.output = output
        self.main?.push(onboardWelcome, animated: false)
        return onboardWelcome
    }

    @discardableResult
    func openOnboardSignIn(output: OnboardSignInViewOutput?) -> OnboardSignInViewInput {
        let onboardSignIn = OnboardSignInViewAlpha()
        onboardSignIn.output = output
        self.main?.raise(onboardSignIn, animated: true)
        return onboardSignIn
    }

    @discardableResult
    func openOnboardSignUp(output: OnboardSignUpViewOutput?) -> OnboardSignUpViewInput {
        let onboardSignUp = OnboardSignUpViewAlpha()
        onboardSignUp.output = output
        self.main?.raise(onboardSignUp, animated: true)
        return onboardSignUp
    }

    @discardableResult
    func openResetPassword(output: OnboardResetPasswordViewOutput?) -> OnboardResetPasswordViewInput {
        let onboardResetPassword = OnboardResetPasswordViewAlpha()
        onboardResetPassword.output = output
        self.main?.push(onboardResetPassword, animated: true)
        return onboardResetPassword
    }

    @discardableResult
    func openSelectRole(output: SelectRoleViewOutput?) -> SelectRoleViewInput {
        let selectRoleView = SelectRoleViewAlpha()
        selectRoleView.output = output
        self.main?.push(selectRoleView, animated: true)
        return selectRoleView
    }

    @discardableResult
    func openOnboardMember(output: OnboardMemberViewOutput?) -> OnboardMemberViewInput {
        let onboardMember = OnboardMemberViewAlpha()
        onboardMember.output = output
        self.main?.push(onboardMember, animated: true)
        return onboardMember
    }

    @discardableResult
    func openSelectOrganization(output: SelectOrganizationViewOutput?) -> SelectOrganizationViewInput {
        let selectOrganization = SelectOrganizationViewAlpha()
        selectOrganization.output = output
        self.main?.push(selectOrganization, animated: true)
        return selectOrganization
    }

    @discardableResult func openOnboardOrganization(output: OnboardOrganizationViewOutput?) -> OnboardOrganizationViewInput {
        let onboardOrganization = OnboardOrganizationViewAlpha()
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

    func pop() {
        self.main?.pop()
    }
}
