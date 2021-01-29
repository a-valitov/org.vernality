// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PCSupplierProfile",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "PCSupplierProfile",
            targets: ["PCSupplierProfile"]),
    ],
    dependencies: [
        .package(path: "../../../../Pods/Packages/ErrorPresenter"),
        .package(path: "../../../../Pods/Packages/ActivityPresenter"),
        .package(path: "../../Services/PCSupplierService"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "6.0.1"),
    ],
    targets: [
        .target(
            name: "PCSupplierProfile",
            dependencies: [
                "ActivityPresenter",
                "ErrorPresenter",
                "Kingfisher",
                .product(name: "PCSupplierServiceStub", package: "PCSupplierService"),
            ]),
        .testTarget(
            name: "PCSupplierProfileTests",
            dependencies: ["PCSupplierProfile"]),
    ]
)
