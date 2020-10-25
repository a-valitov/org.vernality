

import Foundation
import ProfitClubModel

public protocol PCActionService {
    func add(action: PCAction, result: @escaping (Result<PCAction, Error>) -> Void)
    func fetchApproved(result: @escaping (Result<[AnyPCAction], Error>) -> Void)
}
