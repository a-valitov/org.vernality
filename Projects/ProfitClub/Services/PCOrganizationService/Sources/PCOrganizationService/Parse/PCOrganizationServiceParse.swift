//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/30/20
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
import PCModel
import Parse

public final class PCOrganizationServiceParse: PCOrganizationService {
    public init() {}
    
    public func reload(_ organization: PCOrganization?,
                result: @escaping (Result<PCOrganization, Error>) -> Void) {
        guard let organization = organization else {
            result(.failure(PCOrganizationServiceError.inputIsNil))
            return
        }
        organization.parse.fetchInBackground { (pfOrganization, error) in
            if let error = error {
                result(.failure(error))
            } else if let pcOrganization = pfOrganization?.pcOrganization {
                result(.success(pcOrganization))
            } else {
                result(.failure(PCOrganizationServiceError.bothResultAndErrorAreNil))
            }
        }
    }

    public func fetch(_ status: PCOrganizationStatus, result: @escaping (Result<[AnyPCOrganization], Error>) -> Void) {
        let query = PFQuery(className: "Organization")
        query.whereKey("statusString", equalTo: status.rawValue)
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                result(.failure(error))
            } else if let objects = objects {
                result(.success(objects.map({ $0.pcOrganization.any })))
            }
        }
    }

    public func approve(organization: PCOrganization, result: @escaping (Result<PCOrganization, Error>) -> Void) {
        let parseOrganization = organization.parse
        parseOrganization.status = .approved
        parseOrganization.saveInBackground { (success, error) in
            if let error = error {
                result(.failure(error))
            } else {
                result(.success(parseOrganization.any))
            }
        }
    }

    public func reject(organization: PCOrganization, result: @escaping (Result<PCOrganization, Error>) -> Void) {
        let parseOrganization = organization.parse
        parseOrganization.status = .rejected
        parseOrganization.saveInBackground { (success, error) in
            if let error = error {
                result(.failure(error))
            } else {
                result(.success(parseOrganization.any))
            }
        }
    }

    public func approve(member: PCMember, result: @escaping (Result<PCMember, Error>) -> Void) {
        let parseMember = member.parse
        parseMember.status = .approved
        parseMember.saveInBackground { (success, error) in
            if let error = error {
                result(.failure(error))
            } else {
                result(.success(parseMember.any))
            }
        }
    }

    public func reject(member: PCMember, result: @escaping (Result<PCMember, Error>) -> Void) {
        let parseMember = member.parse
        parseMember.status = .rejected
        parseMember.saveInBackground { (success, error) in
            if let error = error {
                result(.failure(error))
            } else {
                result(.success(parseMember.any))
            }
        }
    }

    public func editProfile(organization: PCOrganization, image: UIImage, result: @escaping (Result<PCOrganization, Error>) -> Void) {
        guard let imageData = image.pngData() else {
            result(.failure(PCOrganizationServiceError.failedToGetImagePNGRepresentation))
            return
        }
        let parseOrganization = organization.parse
        let imageFile = PFFileObject(name: "image.png", data: imageData)
        parseOrganization.imageFile = imageFile
        parseOrganization.saveInBackground { (success, error) in
            if let error = error {
                result(.failure(error))
            } else {
                result(.success(parseOrganization.pcOrganization))
            }
        }
    }

    public func fetchApprovedApplications(_ organization: PCOrganization?, result: @escaping (Result<[AnyPCMember], Error>) -> Void) {
        guard let organization = organization else {
            result(.failure(PCOrganizationServiceError.inputIsNil))
            return
        }

        let relation = organization.parse.relation(forKey: "members").query()
        relation.whereKey("statusString", equalTo: "onReview")
        relation.findObjectsInBackground { (members: [PFObject]?, error: Error?) in
            if let error = error {
                result(.failure(error))
            } else if let members = members {
                result(.success(members.map({ $0.pcMember.any })))
            }
        }
    }

    public func fetchApprovedMembersOfOrganization(_ organization: PCOrganization?, result: @escaping (Result<[AnyPCMember], Error>) -> Void) {
        guard let organization = organization else {
            result(.failure(PCOrganizationServiceError.inputIsNil))
            return
        }

        let relation = organization.parse.relation(forKey: "members").query()
        relation.whereKey("statusString", equalTo: "approved")
        relation.findObjectsInBackground { (members: [PFObject]?, error: Error?) in
            if let error = error {
                result(.failure(error))
            } else if let members = members {
                result(.success(members.map({ $0.pcMember.any })))
            }
        }
    }
}
