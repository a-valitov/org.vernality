//
//  File.swift
//  
//
//  Created by Rinat Enikeev on 24.01.2021.
//

import Foundation
import PCModel

public final class PCOrganizationServiceParseFactory: PCOrganizationServiceFactory {
    public init() {
    }

    public func make(organization: PCOrganization) -> PCOrganizationService {
        return PCOrganizationServiceParse(
            organization: organization
        )
    }
}
