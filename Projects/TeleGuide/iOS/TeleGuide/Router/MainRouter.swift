//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/21/20
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
import Login
import Folders
import Channels
import Main
import UserModel
import TeleGuideModel
import Authentication
import RealmManager
import PhoneView
import CodeView
import PasswordView
import ConnectTelegram

final class MainRouter {
    init(authentication: Authentication,
         realmManager: RealmManager) {
        self.authentication = authentication
        self.realmManager = realmManager
    }

    // dependencies
    private let authentication: Authentication
    private let realmManager: RealmManager

    // modules
    private weak var mainModule: MainModule?

    // helpers
    private var isLoggedIn: Bool {
        return self.authentication.user != nil
    }
}

extension MainRouter: MainModuleOutput {
    func mainDidLoad(module: MainModule) {
        self.mainModule = module
        if self.isLoggedIn {
            do {
                try self.realmManager.authorize()
            } catch {
                assertionFailure()
                print(error.localizedDescription)
            }
        }
    }

    func mainWillAppear(module: MainModule) {
        if self.isLoggedIn {
            let folders = Assembler.shared.assembleFolders(for: self)
            self.mainModule?.push(folders, animated: true)
        } else {
            let login = Assembler.shared.assembleLogin(for: self)
            self.mainModule?.push(login, animated: true)
        }
    }
}

extension MainRouter: LoginModuleOutput {
    func login(module: LoginModule, loggedIn user: AnyUser) {
        let folders = Assembler.shared.assembleFolders(for: self)
        self.mainModule?.push(folders, animated: true)
    }
}

extension MainRouter: FoldersModuleOutput {
    func folders(module: FoldersModule, didLogout success: Bool) {
        self.mainModule?.unwindToRoot()
    }

    func folders(module: FoldersModule, didSelect folder: AnyFolder) {
        let channels = Assembler.shared.assembleChannels(folder: folder, output: self)
        self.mainModule?.push(channels, animated: true)
    }
}

extension MainRouter: ChannelsModuleOutput {
    func channels(module: ChannelsModule, didSelect channel: AnyChannel) {
        
    }

    func channels(module: ChannelsModule, userWantsToAddChannelInside folder: AnyFolder) {
        let connectTelegramNavigationController = Assembler.shared.assembleConnectTelegram(output: self)
        self.mainModule?.raise(connectTelegramNavigationController, animated: true)
    }
}

extension MainRouter: ConnectTelegramOutput {
    func connectTelegram(module: ConnectTelegram, didConnect success: Bool) {
        self.mainModule?.unraise(animated: true)
    }

    func connectTelegram(module: ConnectTelegram, didDisconnect success: Bool) {
    }
}
