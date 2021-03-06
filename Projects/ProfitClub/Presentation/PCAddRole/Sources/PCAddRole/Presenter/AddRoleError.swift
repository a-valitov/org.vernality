//  Copyright (C) 2021 Startup Studio Vernality
//  Created by Rinat Enikeev on 22.01.2021
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

enum AddRoleError: Error {
    case firstNameIsEmpty
    case lastNameIsEmpty
    case memberImageIsNil
    case supplierNameIsEmpty
    case supplierInnIsEmpty
    case supplierContactIsEmpty
    case supplierPhoneIsEmpty
    case supplierImageIsNil
    case organizationNameIsEmpty
    case organizationInnIsEmpty
    case organizationContactIsEmpty
    case organizationPhoneIsEmpty
    case organizationImageIsNil
}

extension AddRoleError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .firstNameIsEmpty:
            return "Введите имя"
        case .lastNameIsEmpty:
            return "Введите фамилию"
        case .memberImageIsNil:
            return "Добавьте фото"
        case .supplierNameIsEmpty:
            return "Введите название компании"
        case .supplierInnIsEmpty:
            return "Введите ИНН"
        case .supplierContactIsEmpty:
            return "Введите ФИО контактного лица"
        case .supplierPhoneIsEmpty:
            return "Введите номер телефона"
        case .supplierImageIsNil:
            return "Добавьте изображение"
        case .organizationNameIsEmpty:
            return "Введите название компании"
        case .organizationInnIsEmpty:
            return "Введите ИНН"
        case .organizationContactIsEmpty:
            return "Введите ФИО контактного лица"
        case .organizationPhoneIsEmpty:
            return "Введите номер телефона"
        case .organizationImageIsNil:
            return "Добавьте изображение"
        }
        
    }
}
