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
import UIKit
import PCModel

public protocol PCUserService {
    var user: PCUser { get }

    func isOnReview() -> Bool
    func logout(result: @escaping (Result<Bool, Error>) -> Void)
    func reload(result: @escaping (Result<AnyPCUser, Error>) -> Void)

    func add(member: PCMember,
             in organization: PCOrganization,
             result: @escaping ((Result<PCMember, Error>) -> Void))
    func add(supplier: PCSupplier,
             result: @escaping ((Result<PCSupplier, Error>) -> Void))
    func add(organization: PCOrganization,
             result: @escaping ((Result<PCOrganization, Error>) -> Void))

    func editProfile(member: PCMember,
                     image: UIImage,
                     result: @escaping (Result<PCMember, Error>) -> Void)
}

public protocol PCUserServiceFactory {
    func make() -> PCUserService
}
