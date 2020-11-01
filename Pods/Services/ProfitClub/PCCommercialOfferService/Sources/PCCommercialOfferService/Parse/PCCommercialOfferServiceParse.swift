//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 10/31/20
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

public final class PCCommercialOfferServiceParse: PCCommercialOfferService {
    public init() {}

    public func add(offer: PCCommercialOffer, result: @escaping (Result<PCCommercialOffer, Error>) -> Void) {
        let parseOffer = offer.parse
        let currentUser = PFUser.current()
        if let currentUser = currentUser {
            let acl = PFACL(user: currentUser)
            acl.hasPublicReadAccess = false
            acl.hasPublicWriteAccess = false
            acl.setReadAccess(true, forRoleWithName: PCRole.administrator.rawValue)
            acl.setWriteAccess(true, forRoleWithName: PCRole.administrator.rawValue)
            acl.setWriteAccess(false, for: currentUser)
            acl.setReadAccess(true, for: currentUser)
            parseOffer.acl = acl
            parseOffer.relation(forKey: "user").add(currentUser)
        }
        if let supplier = offer.supplier {
            parseOffer["supplier"] = PFObject(withoutDataWithClassName: "Supplier", objectId: supplier.id)
        }
        if let organization = offer.organization {
            parseOffer["organization"] = PFObject(withoutDataWithClassName: "Organization", objectId: organization.id)
        }
        if let image = offer.image, let imageData = image.pngData() {
            let imageFile = PFFileObject(name: "image.png", data: imageData)
            parseOffer.imageFile = imageFile
        }
        if let attachmentData = offer.attachment, let name = offer.attachmentName {
            let attachmentFile = PFFileObject(name: name, data: attachmentData)
            parseOffer.attachmentFile = attachmentFile
        }
        parseOffer.saveInBackground { (succeeded, error) in
            if let error = error {
                result(.failure(error))
            } else {
                result(.success(offer))
            }
        }
    }

    public func fetchApproved(result: @escaping (Result<[AnyPCCommercialOffer], Error>) -> Void) {
        let query = PFQuery(className: "CommercialOffer")
        query.order(byDescending: "createdAt")
        query.includeKeys(["supplier", "organization"])
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                result(.failure(error))
            } else if let objects = objects {
                result(.success(objects.map({ $0.pcCommercialOffer.any })))
            }
        }
    }

}
