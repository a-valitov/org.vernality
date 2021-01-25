//  Copyright (C) 2020 Startup Studio Vernality
//  Created by Rinat Enikeev on 8/30/20
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General License for more details.
//
//  You should have received a copy of the GNU General License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

import Foundation
import UIKit
import PCModel
import PCOrganizationService

final class PCOrganizationServiceStub: PCOrganizationService {
    let organization: PCOrganization
    
    init(organization: PCOrganization) {
        self.organization = organization
    }

    func reload(_ organization: PCOrganization?,
                result: @escaping (Result<PCOrganization, Error>) -> Void) {
        guard let organization = organization else {
            result(.failure(PCOrganizationServiceError.inputIsNil))
            return
        }
        result(.success(organization))
    }

    func fetch(_ status: PCOrganizationStatus, result: @escaping (Result<[AnyPCOrganization], Error>) -> Void) {
        result(.success([]))
    }

    func approve(organization: PCOrganization, result: @escaping (Result<PCOrganization, Error>) -> Void) {
        result(.success(organization))
    }

    func reject(organization: PCOrganization, result: @escaping (Result<PCOrganization, Error>) -> Void) {
        result(.success(organization))
    }

    func approve(member: PCMember, result: @escaping (Result<PCMember, Error>) -> Void) {
        result(.success(member))
    }

    func reject(member: PCMember, result: @escaping (Result<PCMember, Error>) -> Void) {
        result(.success(member))
    }

    func editProfile(organization: PCOrganization, image: UIImage, result: @escaping (Result<PCOrganization, Error>) -> Void) {
        result(.success(organization))
    }

    func fetchApprovedApplications(_ organization: PCOrganization?, result: @escaping (Result<[AnyPCMember], Error>) -> Void) {
        result(.success([]))
    }

    func fetchApprovedMembersOfOrganization(_ organization: PCOrganization?, result: @escaping (Result<[AnyPCMember], Error>) -> Void) {
        result(.success([]))
    }
}
