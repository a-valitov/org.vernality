// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PCAddRole",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "PCAddRole",
            targets: ["PCAddRole"]),
    ],
    dependencies: [
        .package(path: "../../Model/PCModel"),
        .package(path: "../../Services/PCUserService"),
        .package(path: "../../../../Pods/Packages/ErrorPresenter"),
        .package(path: "../../../../Pods/Packages/ConfirmationPresenter"),
        .package(path: "../../../../Pods/Packages/ActivityPresenter"),
    ],
    targets: [
        .target(
            name: "PCAddRole",
            dependencies: [
                .product(name: "PCUserServiceStub", package: "PCUserService"),
                "PCModel",
                "PCUserService",
                "ErrorPresenter",
                "ConfirmationPresenter",
                "ActivityPresenter",
            ]),
        .testTarget(
            name: "PCAddRoleTests",
            dependencies: ["PCAddRole"]),
    ]
)
