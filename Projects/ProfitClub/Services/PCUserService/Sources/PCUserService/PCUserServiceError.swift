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

public enum PCUserServiceError: Error {
    case userIsNil
    case userIsNotPFUser
    case bothResultAndErrorAreNil
    case failedToGetImagePNGRepresentation
    case organizationOrUserIdIsNil
}

extension PCUserServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .userIsNil:
            return "Пользователь не найден"
        case .userIsNotPFUser:
            return "Пользователь не является членом Profit Club"
        case .bothResultAndErrorAreNil:
            return "Неопределённая ошибка: пользователь не найден"
        case .failedToGetImagePNGRepresentation:
            return "Не удалось преобразовать изображение в формат PNG"
        case .organizationOrUserIdIsNil:
            return "Организация или пользователь с такими id не найдены"
        }
    }
}
