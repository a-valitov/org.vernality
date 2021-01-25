//
//  File.swift
//  
//
//  Created by Rinat Enikeev on 25.01.2021.
//

import Foundation
import PCModel

public final class PCSupplierServiceParseFactory: PCSupplierServiceFactory {
    public init() {
    }

    public func make() -> PCSupplierService {
        return PCSupplierServiceParse()
    }
}
