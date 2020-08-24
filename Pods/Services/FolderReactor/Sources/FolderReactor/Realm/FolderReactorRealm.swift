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
import RealmSwift
import RealmManager
import TeleGuideModel
import TeleGuideRealm

final class FolderReactorRealm: FolderReactor {
    init(realmManager: RealmManager) {
        self.realmManager = realmManager
    }

    func observe(_ block: @escaping (FolderReactorChange<AnyFolder>) -> Void) -> FolderObservationToken {
        guard let realm = self.realmManager.main else {
            assertionFailure()
            block(.error(FolderReactorRealmError.realmNotInitialized))
            return FolderObservationToken {
            }
        }
        let folders = realm.objects(FolderRealm.self).sorted(byKeyPath: "name")
        let token = folders.observe { change in
            switch change {
            case .initial(let folders):
                block(.initial(folders.map({ $0.any })))
            case .update(let folders, let deletions, let insertions, let modifications):
                block(.update(folders.map({ $0.any }), deletions: deletions, insertions: insertions, modifications: modifications))
            case .error(let error):
                block(.error(error))
            }
        }
        return FolderObservationToken {
            token.invalidate()
        }
    }

    private let realmManager: RealmManager
}

