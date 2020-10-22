

import Foundation
import ProfitClubModel

public protocol PCActionService {
    func addAction(message: String, descriptionOf: String, link: String, result: @escaping (Result<PCAction, Error>) -> Void)
}
