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
import FolderStorage
import ErrorPresenter
import ActivityPresenter

public final class FoldersAssembler {
    public struct Dependencies {
        let authentication: Authentication
        let folderReactor: FolderReactor
        let folderStorage: FolderStorage
        let errorPresenter: ErrorPresenter
        let activityPresenter: ActivityPresenter

        public init(authentication: Authentication,
                    folderReactor: FolderReactor,
                    folderStorage: FolderStorage,
                    errorPresenter: ErrorPresenter,
                    activityPresenter: ActivityPresenter) {
            self.authentication = authentication
            self.folderReactor = folderReactor
            self.folderStorage = folderStorage
            self.errorPresenter = errorPresenter
            self.activityPresenter = activityPresenter
        }
    }

    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    public func assemble(output: FoldersModuleOutput) -> FoldersModule & FoldersViewOutput {
        let presenter = FoldersPresenter(authentication: self.dependencies.authentication,
                                         folderReactor: self.dependencies.folderReactor,
                                         folderStorage: self.dependencies.folderStorage,
                                         errorPresenter: self.dependencies.errorPresenter,
                                         activityPresenter: self.dependencies.activityPresenter)
        presenter.output = output
        return presenter
    }

    private let dependencies: Dependencies
}
