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
import ProfitClubModel

public protocol PCOrganizationService {
    func reload(_ organization: PCOrganization?,
                result: @escaping (Result<PCOrganization, Error>) -> Void)
    func fetch(_ status: PCOrganizationStatus, result: @escaping (Result<[AnyPCOrganization], Error>) -> Void)
    func fetchApprovedApplications(_ organization: PCOrganization?, result: @escaping (Result<[AnyPCMember], Error>) -> Void)
    func fetchApprovedMembersOfOrganization(_ organization: PCOrganization?, result: @escaping (Result<[AnyPCMember], Error>) -> Void)

    func approve(member: PCMember, result: @escaping (Result<PCMember, Error>) -> Void)
    func reject(member: PCMember, result: @escaping (Result<PCMember, Error>) -> Void)

    func approve(organization: PCOrganization, result: @escaping (Result<PCOrganization, Error>) -> Void)
    func reject(organization: PCOrganization, result: @escaping (Result<PCOrganization, Error>) -> Void)

    func editProfile(organization: PCOrganization, image: UIImage, result: @escaping (Result<PCOrganization, Error>) -> Void)
}
