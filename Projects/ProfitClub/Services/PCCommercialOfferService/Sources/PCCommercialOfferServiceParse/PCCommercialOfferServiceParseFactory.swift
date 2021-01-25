//
//  File.swift
//  
//
//  Created by Rinat Enikeev on 25.01.2021.
//

import Foundation
import PCModel
import PCCommercialOfferService

public final class PCCommercialOfferServiceParseFactory: PCCommercialOfferServiceFactory {
    public init() {
    }

    public func make() -> PCCommercialOfferService {
        return PCCommercialOfferServiceParse()
    }
}
