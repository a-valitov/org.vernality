//
//  File.swift
//  
//
//  Created by Rinat Enikeev on 25.01.2021.
//

import Foundation
import PCModel
import PCActionService

public final class PCActionServiceStubFactory: PCActionServiceFactory {
    public init() {
    }

    public func make() -> PCActionService {
        return PCActionServiceStub()
    }
}
