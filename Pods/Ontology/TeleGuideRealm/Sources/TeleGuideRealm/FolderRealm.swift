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
import TeleGuideModel

public class FolderRealm: Object, Folder {
    @objc public dynamic var _id = ObjectId.generate()
    @objc public dynamic var _partition = ""
    @objc public dynamic var name = ""

    public var id: String {
        return self._id.stringValue
    }

    public override static func primaryKey() -> String? {
        return "_id"
    }

    public convenience init(partition: String, name: String) {
        self.init()
        self._partition = partition
        self.name = name
    }
}
