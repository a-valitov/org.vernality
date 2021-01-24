// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PCOrganizationService",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "PCOrganizationService",
            targets: ["PCOrganizationService"]),
        .library(
            name: "PCOrganizationServiceStub",
            targets: ["PCOrganizationServiceStub"]),
    ],
    dependencies: [
        .package(path: "../../Model/PCModel"),
    ],
    targets: [
        .target(
            name: "PCOrganizationService",
            dependencies: ["PCModel"]),
        .target(
            name: "PCOrganizationServiceStub",
            dependencies: [
                "PCModel",
                "PCOrganizationService",
            ]
        ),
        .testTarget(
            name: "PCOrganizationServiceTests",
            dependencies: ["PCOrganizationService"]),
    ]
)
