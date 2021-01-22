//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Macbook on 07.01.2021
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
import PCModelParse
import PCModel
import Parse

public final class PCSupplierServiceParse: PCSupplierService {
    public init() {}

    public func fetch(_ status: PCSupplierStatus, result: @escaping (Result<[AnyPCSupplier], Error>) -> Void) {
        let query = PFQuery(className: "Supplier")
        query.whereKey("statusString", equalTo: status.rawValue)
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                result(.failure(error))
            } else if let objects = objects {
                result(.success(objects.map({ $0.pcSupplier.any })))
            }
        }
    }

    public func approve(supplier: PCSupplier, result: @escaping (Result<PCSupplier, Error>) -> Void) {
        let parseSupplier = supplier.parse
        parseSupplier.status = .approved
        parseSupplier.saveInBackground { (success, error) in
            if let error = error {
                result(.failure(error))
            } else {
                result(.success(parseSupplier.any))
            }
        }
    }

    public func reject(supplier: PCSupplier, result: @escaping (Result<PCSupplier, Error>) -> Void) {
        let parseSupplier = supplier.parse
        parseSupplier.status = .rejected
        parseSupplier.saveInBackground { (success, error) in
            if let error = error {
                result(.failure(error))
            } else {
                result(.success(parseSupplier.any))
            }
        }
    }

    public func editProfile(supplier: PCSupplier, image: UIImage, result: @escaping (Result<PCSupplier, Error>) -> Void) {
        guard let imageData = image.pngData() else {
            result(.failure(PCSupplierServiceError.failedToGetImagePNGRepresentation))
            return
        }
        let parseSupplier = supplier.parse
        let imageFile = PFFileObject(name: "image.png", data: imageData)
        parseSupplier.imageFile = imageFile
        parseSupplier.saveInBackground { (success, error) in
            if let error = error {
                result(.failure(error))
            } else {
                result(.success(parseSupplier.pcSupplier))
            }
        }
    }
}
