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
import RealmManager
import RealmSwift
import TeleGuideModel
import TeleGuideRealm

final class FolderStorageRealm: FolderStorage {
    init(realmManager: RealmManager) {
        self.realmManager = realmManager
    }

    func storeFolder(name: String, result: @escaping (Result<AnyFolder, Error>) -> Void) {
        guard let partition = self.realmManager.partition else {
            assertionFailure()
            result(.failure(FolderStorageRealmError.partitionNotInitialized))
            return
        }
        guard let realm = self.realmManager.main else {
            assertionFailure()
            result(.failure(FolderStorageRealmError.realmNotInitialized))
            return
        }
        let folder = FolderRealm(partition: partition, name: name)
        do {
            try realm.write {
                realm.add(folder)
            }
            result(.success(FolderStruct(id: folder.id, name: name).any))
        } catch {
            result(.failure(error))
        }
    }

    func deleteFolder(_ folder: AnyFolder, result: @escaping (Result<Bool, Error>) -> Void) {
        guard let realm = self.realmManager.main else {
            assertionFailure()
            result(.failure(FolderStorageRealmError.realmNotInitialized))
            return
        }
        do {
            let id = try ObjectId(string: folder.id)
            if let folder = realm.object(ofType: FolderRealm.self, forPrimaryKey: id) {
                try realm.write {
                    realm.delete(folder)
                }
                result(.success(true))
            } else {
                result(.failure(FolderStorageRealmError.objectNotFound))
            }
        } catch {
            result(.failure(error))
        }
    }

    private let realmManager: RealmManager
}
