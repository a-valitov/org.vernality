// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PCUserPersistence",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "PCUserPersistence",
            targets: ["PCUserPersistence"]),
        .library(
            name: "PCUserPersistenceStub",
            targets: ["PCUserPersistenceStub"]),
    ],
    dependencies: [
        .package(path: "../../Model/PCModel"),
    ],
    targets: [
        .target(
            name: "PCUserPersistence",
            dependencies: ["PCModel"]),
        .target(
            name: "PCUserPersistenceStub",
            dependencies: [
                "PCModel",
                "PCUserPersistence",
            ]
        ),
        .testTarget(
            name: "PCUserPersistenceTests",
            dependencies: ["PCUserPersistence"]),
    ]
)
