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
import PCModel
import PCActionService

final class PCActionServiceStub: PCActionService {
    init() {}

    func add(action: PCAction, result: @escaping (Result<PCAction, Error>) -> Void) {
        result(.success(action))
    }

    func fetchApprovedCurrentActions(result: @escaping (Result<[AnyPCAction], Error>) -> Void) {
        result(.success([]))
    }

    func fetchApprovedPastActions(result: @escaping (Result<[AnyPCAction], Error>) -> Void) {
        result(.success([]))
    }

    func fetch(_ status: PCActionStatus, result: @escaping (Result<[AnyPCAction], Error>) -> Void) {
        result(.success([]))
    }

    func approve(action: PCAction, result: @escaping (Result<PCAction, Error>) -> Void) {
        result(.success(action))
    }


    func reject(action: PCAction, result: @escaping (Result<PCAction, Error>) -> Void) {
        result(.success(action))
    }

    func fetch(_ actionId: String, result: @escaping (Result<PCAction, Error>) -> Void) {
        result(.success(PCActionStruct()))
    }
}
