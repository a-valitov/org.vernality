// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PCCommercialOfferService",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "PCCommercialOfferService",
            targets: ["PCCommercialOfferService"]),
        .library(
            name: "PCCommercialOfferServiceStub",
            targets: ["PCCommercialOfferServiceStub"]),
    ],
    dependencies: [
        .package(path: "../../Model/PCModel"),
    ],
    targets: [
        .target(
            name: "PCCommercialOfferService",
            dependencies: ["PCModel"]),
        .target(
            name: "PCCommercialOfferServiceStub",
            dependencies: [
                "PCModel",
                "PCCommercialOfferService",
            ]
        ),
        .testTarget(
            name: "PCCommercialOfferServiceTests",
            dependencies: ["PCCommercialOfferService"]),
    ]
)
