// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PCSupplierService",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "PCSupplierService",
            targets: ["PCSupplierService"]),
        .library(
            name: "PCSupplierServiceStub",
            targets: ["PCSupplierServiceStub"]),
    ],
    dependencies: [
        .package(path: "../../Model/PCModel"),
    ],
    targets: [
        .target(
            name: "PCSupplierService",
            dependencies: [
                "PCModel"
            ]),
        .target(
            name: "PCSupplierServiceStub",
            dependencies: [
                "PCModel",
                "PCSupplierService",
            ]
        ),
        .testTarget(
            name: "PCSupplierServiceTests",
            dependencies: ["PCSupplierService"]),
    ]
)
