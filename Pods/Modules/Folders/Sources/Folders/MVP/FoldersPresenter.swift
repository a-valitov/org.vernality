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
import Authentication
import FolderReactor
import TeleGuideModel
import FolderStorage
import ErrorPresenter
import ActivityPresenter

final class FoldersPresenter {
    weak var view: FoldersViewInput?
    weak var output: FoldersModuleOutput?

    init(authentication: Authentication,
         folderReactor: FolderReactor,
         folderStorage: FolderStorage,
         errorPresenter: ErrorPresenter,
         activityPresenter: ActivityPresenter) {
        self.authentication = authentication
        self.folderReactor = folderReactor
        self.folderStorage = folderStorage
        self.errorPresenter = errorPresenter
        self.activityPresenter = activityPresenter
        self.startObservingFolders()
    }

    // dependencies
    private let authentication: Authentication
    private let folderReactor: FolderReactor
    private let folderStorage: FolderStorage
    private let errorPresenter: ErrorPresenter
    private let activityPresenter: ActivityPresenter

    // helpers
    private var foldersToken: FolderObservationToken?

    deinit {
        self.stopObservingFolders()
    }
}

extension FoldersPresenter: FoldersModule {
}

extension FoldersPresenter: FoldersViewOutput {
    func userWantsToLogout() {
        self.activityPresenter.increment()
        self.authentication.logout { [weak self] result in
            guard let sSelf = self else { return }
            sSelf.activityPresenter.decrement()
            switch result {
            case .success(let success):
                sSelf.output?.folders(module: sSelf, didLogout: success)
            case .failure(let error):
                sSelf.errorPresenter.present(error)
            }
        }
    }

    func userWantsToAddFolder() {
        self.view?.showAddFolderDialog()
    }

    func userWantsToAddFolderWithName(_ name: String) {
        self.activityPresenter.increment()
        self.folderStorage.storeFolder(name: name) { [weak self] result in
            self?.activityPresenter.decrement()
            switch result {
            case .success:
                break
            case .failure(let error):
                self?.errorPresenter.present(error)
            }
        }
    }

    func userWantsToOpenFolder(_ folder: AnyFolder) {
        self.output?.folders(module: self, didSelect: folder)
    }

    func userWantsToDeleteFolder(_ folder: AnyFolder) {
        self.activityPresenter.increment()
        self.folderStorage.deleteFolder(folder) { [weak self] (result) in
            self?.activityPresenter.decrement()
            switch result {
            case .success:
                break
            case .failure(let error):
                self?.errorPresenter.present(error)
            }
        }
    }
}

extension FoldersPresenter {
    private func startObservingFolders() {
    self.stopObservingFolders()
        self.foldersToken = self.folderReactor.observe({ [weak self] change in
            switch change {
            case .initial(let folders):
                self?.view?.folders = folders
            case .update(let folders, _, _, _):
                self?.view?.folders = folders
            case .error(let error):
                self?.errorPresenter.present(error)
            }
        })
    }

    private func stopObservingFolders() {
        self.foldersToken?.invalidate()
    }
}
