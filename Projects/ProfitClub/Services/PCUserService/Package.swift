// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PCUserService",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "PCUserService",
            targets: ["PCUserService"]),
        .library(
            name: "PCUserServiceStub",
            targets: ["PCUserServiceStub"]),
    ],
    dependencies: [
        .package(path: "../../Model/PCModel"),
        .package(path: "../../Persistence/PCUserPersistence"),
    ],
    targets: [
        .target(
            name: "PCUserService",
            dependencies: ["PCModel"]),
        .target(
            name: "PCUserServiceStub",
            dependencies: [
                "PCModel",
                "PCUserService",
                .product(name: "PCUserPersistenceStub", package: "PCUserPersistence"),
            ]
        ),
        .testTarget(
            name: "PCUserServiceTests",
            dependencies: ["PCUserService"]),
    ]
)
