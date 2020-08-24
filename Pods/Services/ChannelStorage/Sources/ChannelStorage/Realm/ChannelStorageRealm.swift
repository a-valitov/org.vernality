//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/22/20
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

final class ChannelStorageRealm: ChannelStorage {
    init(realmManager: RealmManager) {
        self.realmManager = realmManager
    }

    func storeChannel(name: String, type: ChannelType, result: @escaping (Result<AnyChannel, Error>) -> Void) {
        guard let partition = self.realmManager.partition else {
            assertionFailure()
            result(.failure(ChannelStorageRealmError.partitionNotInitialized))
            return
        }
        guard let realm = self.realmManager.main else {
            assertionFailure()
            result(.failure(ChannelStorageRealmError.realmNotInitialized))
            return
        }
        let channel = ChannelRealm(partition: partition, name: name)
        channel.typeEnum = type
        do {
            try realm.write {
                realm.add(channel)
            }
            let channelStruct = ChannelStruct(id: channel.id, name: name, type: type).any
            result(.success(channelStruct))
        } catch {
            result(.failure(error))
        }
    }

    func deleteChannel(_ channel: AnyChannel, result: @escaping (Result<Bool, Error>) -> Void) {
        guard let realm = self.realmManager.main else {
            assertionFailure()
            result(.failure(ChannelStorageRealmError.realmNotInitialized))
            return
        }
        do {
            let id = try ObjectId(string: channel.id)
            if let channel = realm.object(ofType: ChannelRealm.self, forPrimaryKey: id) {
                try realm.write {
                    realm.delete(channel)
                }
            } else {
                result(.failure(ChannelStorageRealmError.objectNotFound))
            }
        } catch {
            result(.failure(error))
        }
    }

    private let realmManager: RealmManager
}

