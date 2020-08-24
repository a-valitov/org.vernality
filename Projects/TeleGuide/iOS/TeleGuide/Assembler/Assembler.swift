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
import Main
import Login
import LoginView
import Folders
import FoldersView
import RealmManager
import Authentication
import FolderReactor
import FolderStorage
import Channels
import ChannelsView
import ChannelStorage
import ChannelReactor
import TeleGuideModel
import ErrorPresenter
import ActivityPresenter
import PhoneView
import CodeView
import PasswordView
import ConnectTelegram

final class Assembler {
    static let shared = Assembler()
    let realmManager = RealmManagerFactory().make(appId: Secrets.realmAppId)

    func assembleMainRouter() -> MainRouter {
        let authentication = self.assembleAuthentication()
        let router = MainRouter(authentication: authentication,
                                realmManager: self.realmManager)
        return router
    }

    func assembleMain(for output: MainModuleOutput) -> UINavigationController {
        let factory = MainModuleFactoryMVC()
        return MainModuleAssemblerMVC().assemble(factory: factory, output: output)
    }

    func assembleLogin(for output: LoginModuleOutput) -> UIViewController {
        let authentication = self.assembleAuthentication()
        let errorPresenter = self.assembleErrorPresenter()
        let activityPresenter = self.assembleActivityPresenter()
        let dependencies = LoginAssembler.Dependencies(authentication: authentication,
                                                       errorPresenter: errorPresenter,
                                                       activityPresenter: activityPresenter)
        var module = LoginAssembler(dependencies: dependencies).assemble(output: output)
        let view = LoginViewFactory().makeView(module)
        module.view = view
        return view
    }

    func assembleFolders(for output: FoldersModuleOutput) -> UIViewController {
        let authentication = self.assembleAuthentication()
        let folderReactor = self.assembleFolderReactor()
        let folderStorage = self.assembleFolderStorage()
        let errorPresenter = self.assembleErrorPresenter()
        let activityPresenter = self.assembleActivityPresenter()
        let dependencies = FoldersAssembler.Dependencies(authentication: authentication,
                                                         folderReactor: folderReactor,
                                                         folderStorage: folderStorage,
                                                         errorPresenter: errorPresenter,
                                                         activityPresenter: activityPresenter)
        var module = FoldersAssembler(dependencies: dependencies).assemble(output: output)
        let view = FoldersViewFactory().makeView(module)
        module.view = view
        return view
    }

    func assembleChannels(folder: AnyFolder, output: ChannelsModuleOutput) -> UIViewController {
        let channelReactor = self.assembleChannelReactor()
        let channelStorage = self.assembleChannelStorage()
        let errorPresenter = self.assembleErrorPresenter()
        let activityPresenter = self.assembleActivityPresenter()
        let dependencies = ChannelsAssembler.Dependencies(channelReactor: channelReactor,
                                                          channelStorage: channelStorage,
                                                          errorPresenter: errorPresenter,
                                                          activityPresenter: activityPresenter)
        let assembler = ChannelsAssembler(dependencies: dependencies)
        var module = assembler.assemble(folder: folder, output: output)
        let view = ChannelsViewFactory().makeView(module)
        module.view = view
        return view
    }

    func assembleAuthentication() -> Authentication {
        let authentication = AuthenticationRealmAppFactory().make(realmManager: self.realmManager)
        return authentication
    }

    func assembleFolderReactor() -> FolderReactor {
        let folderReactor = FolderReactorRealmFactory().make(realmManager: self.realmManager)
        return folderReactor
    }

    func assembleFolderStorage() -> FolderStorage {
        let folderStorage = FolderStorageRealmFactory().make(realmManager: self.realmManager)
        return folderStorage
    }

    func assembleChannelReactor() -> ChannelReactor {
        let channelReactor = ChannelReactorRealmFactory().make(realmManager: self.realmManager)
        return channelReactor
    }

    func assembleChannelStorage() -> ChannelStorage {
        let channelStorage = ChannelStorageRealmFactory().make(realmManager: self.realmManager)
        return channelStorage
    }

    func assembleErrorPresenter() -> ErrorPresenter {
        let presenter = ErrorPresenterAlertFactory().make()
        return presenter
    }

    func assembleActivityPresenter() -> ActivityPresenter {
        let presenter = ActivityPresenterCircleFactory().make()
        return presenter
    }

    func assemblePhoneView(output: PhoneViewOutput) -> UIViewController {
        return PhoneViewAlphaFactory().make(output: output)
    }

    func assembleCodeView(output: CodeViewOutput) -> UIViewController {
        return CodeViewAlphaFactory().make(length: 5, output: output)
    }

    func assemblePasswordView(output: PasswordViewOutput) -> UIViewController {
        return PasswordViewAlphaFactory().make(output: output, passwordHint: "Hint")
    }

    func assembleConnectTelegram(output: ConnectTelegramOutput) -> UINavigationController {
        return ConnectTelegramFactory().make(output: output)
    }
}
