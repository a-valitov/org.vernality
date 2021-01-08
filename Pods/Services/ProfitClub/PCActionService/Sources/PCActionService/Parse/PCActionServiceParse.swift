//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Macbook on 22.10.2020
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
import ProfitClubModel
import ProfitClubParse
import Parse

public final class PCActionServiceParse: PCActionService {
    public init() {}

    public func add(action: PCAction, result: @escaping (Result<PCAction, Error>) -> Void) {
        let parseAction = action.parse
        let currentUser = PFUser.current()
        if let currentUser = currentUser {
            let acl = PFACL(user: currentUser)
            acl.hasPublicReadAccess = false
            acl.hasPublicWriteAccess = false
            acl.setReadAccess(true, forRoleWithName: PCRole.administrator.rawValue)
            acl.setWriteAccess(true, forRoleWithName: PCRole.administrator.rawValue)
            acl.setWriteAccess(false, for: currentUser)
            acl.setReadAccess(true, for: currentUser)
            parseAction.acl = acl
            parseAction.relation(forKey: "user").add(currentUser)
        }
        if let supplier = parseAction.supplier {
            parseAction["supplier"] = PFObject(withoutDataWithClassName: "Supplier", objectId: supplier.id)
        }
        if let image = action.image, let imageData = image.pngData() {
            let imageFile = PFFileObject(name: "image.png", data: imageData)
            parseAction.imageFile = imageFile
        }
        parseAction.saveInBackground { (succeeded, error) in
            if let error = error {
                result(.failure(error))
            } else {
                result(.success(action))
            }
        }
    }

    public func fetchApprovedCurrentActions(result: @escaping (Result<[AnyPCAction], Error>) -> Void) {
        let query = PFQuery(className: "Action")
        query.order(byDescending: "createdAt")
        query.includeKey("supplier")
        query.whereKey("statusString", equalTo: "approved")
        query.whereKey("endDate", greaterThanOrEqualTo: Date())
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                result(.failure(error))
            } else if let objects = objects {
                result(.success(objects.map({ $0.pcAction.any })))
            }
        }
    }

    public func fetchApprovedPastActions(result: @escaping (Result<[AnyPCAction], Error>) -> Void) {
        let query = PFQuery(className: "Action")
        query.order(byDescending: "createdAt")
        query.includeKey("supplier")
        query.whereKey("statusString", equalTo: "approved")
        query.whereKey("endDate", lessThan: Date())
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                result(.failure(error))
            } else if let objects = objects {
                result(.success(objects.map({ $0.pcAction.any })))
            }
        }
    }

    public func fetch(_ status: PCActionStatus, result: @escaping (Result<[AnyPCAction], Error>) -> Void) {
        let query = PFQuery(className: "Action")
        query.whereKey("statusString", equalTo: status.rawValue)
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                result(.failure(error))
            } else if let objects = objects {
                result(.success(objects.map({ $0.pcAction.any })))
            }
        }
    }
}
