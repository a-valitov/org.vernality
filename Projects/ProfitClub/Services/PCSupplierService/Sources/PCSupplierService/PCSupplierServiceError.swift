//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Rinat Enikeev on 17.01.2021
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

enum PCSupplierServiceError: Error {
    case failedToGetImagePNGRepresentation
    case supplierIdIsNil
}

extension PCSupplierServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedToGetImagePNGRepresentation:
            return "Не удалось получить PNG данные из изображения"
        case .supplierIdIsNil:
            return "Поставщик не найден"
        }
    }
}
