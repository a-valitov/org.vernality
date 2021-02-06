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

enum SupplierError: Error {
    case actionMessageIsEmpty
    case actionDescriptionOfIsEmpty
    case actionLinkIsEmpty
    case actionImageIsNil
    case actionStartDateIsEmpty
    case actionEndDateIsEmpty
    case actionEndDateIsInPast
    case actionEndDateIsEarlierThanStartDate
    
    case commercialOfferMessageIsEmpty
    case commercialOfferImageIsNil
}

extension SupplierError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .actionMessageIsEmpty:
            return "Введите название"
        case .actionDescriptionOfIsEmpty:
            return "Введите описание"
        case .actionLinkIsEmpty:
            return "Введите ссылку"
        case .actionImageIsNil:
            return "Добавьте изображение"
        case .actionStartDateIsEmpty:
            return "Введите дату начала акции"
        case .actionEndDateIsEmpty:
            return "Введите дату конца акции"
        case .actionEndDateIsInPast:
            return "Нельзя создать уже прошедшую акцию"
        case .actionEndDateIsEarlierThanStartDate:
            return "Конец акции не может быть раньше, чем её начало"
            
        case .commercialOfferMessageIsEmpty:
            return "Введите сообщение"
        case .commercialOfferImageIsNil:
            return "Добавьте изображение"
        }
    }
}
