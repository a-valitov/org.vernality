// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PCActionService",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "PCActionService",
            targets: ["PCActionService"]),
        .library(
            name: "PCActionServiceStub",
            targets: ["PCActionServiceStub"]),
    ],
    dependencies: [
        .package(path: "../../Model/PCModel"),
    ],
    targets: [
        .target(
            name: "PCActionService",
            dependencies: ["PCModel"]),
        .target(
            name: "PCActionServiceStub",
            dependencies: [
                "PCModel",
                "PCActionService",
            ]
        ),
        .testTarget(
            name: "PCActionServiceTests",
            dependencies: ["PCActionService"]),
    ]
)
