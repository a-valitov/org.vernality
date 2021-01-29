// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PCSupplier",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "PCSupplier",
            targets: ["PCSupplier"]),
    ],
    dependencies: [
        .package(path: "../../../../Pods/Packages/ErrorPresenter"),
        .package(path: "../../../../Pods/Packages/MenuPresenter"),
        .package(path: "../../../../Pods/Packages/ConfirmationPresenter"),
        .package(path: "../../../../Pods/Packages/ActivityPresenter"),
        .package(path: "../../Services/PCUserService"),
        .package(path: "../../Services/PCActionService"),
        .package(path: "../../Services/PCCommercialOfferService"),
    ],
    targets: [
        .target(
            name: "PCSupplier",
            dependencies: [
                .product(name: "PCUserServiceStub", package: "PCUserService"),
                .product(name: "PCActionServiceStub", package: "PCActionService"),
                .product(name: "PCCommercialOfferServiceStub", package: "PCCommercialOfferService"),
                "ErrorPresenter",
                "ConfirmationPresenter",
                "ActivityPresenter",
                "MenuPresenter",

            ]),
        .testTarget(
            name: "PCSupplierTests",
            dependencies: ["PCSupplier"]),
    ]
)
