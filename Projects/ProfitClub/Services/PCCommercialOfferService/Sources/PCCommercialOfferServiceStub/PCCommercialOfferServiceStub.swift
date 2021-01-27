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
import PCModel
import PCCommercialOfferService

final class PCCommercialOfferServiceStub: PCCommercialOfferService {
    init() {}

    func add(offer: PCCommercialOffer, result: @escaping (Result<PCCommercialOffer, Error>) -> Void) {
        result(.success(offer))
    }

    func loadAttachment(at index: Int, for offer: PCCommercialOffer, result: @escaping (Result<URL, Error>) -> Void) {
        result(.failure(PCCommercialOfferServiceError.failedToGetFileObject))
    }

    func fetchApproved(result: @escaping (Result<[AnyPCCommercialOffer], Error>) -> Void) {
        result(.success([]))
    }

    func fetch(_ status: PCCommercialOfferStatus, result: @escaping (Result<[AnyPCCommercialOffer], Error>) -> Void) {
        result(.success([]))
    }

    func approve(commercialOffer: PCCommercialOffer, result: @escaping (Result<PCCommercialOffer, Error>) -> Void) {
        result(.success(commercialOffer))
    }

    func reject(commercialOffer: PCCommercialOffer, result: @escaping (Result<PCCommercialOffer, Error>) -> Void) {
        result(.success(commercialOffer))
    }

    func fetch(_ commercialOfferId: String, result: @escaping (Result<PCCommercialOffer, Error>) -> Void) {
        result(.success(PCCommercialOfferStruct()))
    }
}
