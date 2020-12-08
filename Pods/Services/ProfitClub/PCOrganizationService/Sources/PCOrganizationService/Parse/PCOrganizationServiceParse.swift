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
import ProfitClubParse
import ProfitClubModel
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

    public func fetchApproved(result: @escaping (Result<[AnyPCOrganization], Error>) -> Void) {
        let query = PFQuery(className: "Organization")
        query.whereKey("statusString", equalTo: "approved")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                result(.failure(error))
            } else if let objects = objects {
                result(.success(objects.map({ $0.pcOrganization.any })))
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
