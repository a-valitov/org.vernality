//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/23/20
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
import PhoneView
import CodeView
import PasswordView

extension ConnectTelegramRouter: ConnectTelegram {
    
}

final class ConnectTelegramRouter {
    init(navigationController: UINavigationController,
         output: ConnectTelegramOutput,
         phoneViewFactory: PhoneViewFactory,
         codeViewFactory: CodeViewFactory,
         passwordViewFactory: PasswordViewFactory) {
        self.navigationController = navigationController
        self.output = output
        self.phoneViewFactory = phoneViewFactory
        self.codeViewFactory = codeViewFactory
        self.passwordViewFactory = passwordViewFactory
    }

    private weak var navigationController: UINavigationController?
    private weak var output: ConnectTelegramOutput?
    private let phoneViewFactory: PhoneViewFactory
    private let codeViewFactory: CodeViewFactory
    private let passwordViewFactory: PasswordViewFactory
}

extension ConnectTelegramRouter: ConnectTelegramIntroViewControllerDelegate {
    func connectTelegramIntro(_ viewController: ConnectTelegramIntroViewController, userWantsToContinue sender: Any) {
        let phoneView = self.phoneViewFactory.make(output: self)
        self.navigationController?.pushViewController(phoneView, animated: true)
    }
}

extension ConnectTelegramRouter: PhoneViewOutput {
    func phone(view: PhoneViewInput, didEnter e164PhoneNumber: String) {
        let codeView = self.codeViewFactory.make(length: 6, output: self)
        self.navigationController?.pushViewController(codeView, animated: true)
    }
}

extension ConnectTelegramRouter: CodeViewOutput {
    func code(view: CodeViewInput, didInput code: String) {
        let passwordView = self.passwordViewFactory.make(output: self)
        self.navigationController?.pushViewController(passwordView, animated: true)
    }
}

extension ConnectTelegramRouter: PasswordViewOutput {
    func password(view: PasswordViewInput, didEnter password: String) {
        self.output?.connectTelegram(module: self, didConnect: true)
    }
}
