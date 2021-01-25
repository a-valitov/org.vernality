//
//  File.swift
//  
//
//  Created by Rinat Enikeev on 25.01.2021.
//

import Foundation
import PCModel
import PCSupplierService

public final class PCSupplierServiceStubFactory: PCSupplierServiceFactory {
    public init() {
    }

    public func make() -> PCSupplierService {
        return PCSupplierServiceStub()
    }
}
