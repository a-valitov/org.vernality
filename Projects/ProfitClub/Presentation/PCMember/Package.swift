// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PCMember",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "PCMember",
            targets: ["PCMember"]),
    ],
    dependencies: [
        .package(path: "../../Services/PCUserService"),
        .package(path: "../../Services/PCActionService"),
        .package(path: "../../../../Pods/Packages/ErrorPresenter"),
        .package(path: "../../../../Pods/Packages/MenuPresenter"),
        .package(path: "../../../../Pods/Packages/ConfirmationPresenter"),
        .package(path: "../../../../Pods/Packages/ActivityPresenter"),
        .package(path: "../../../../Pods/Packages/Raise"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "6.0.1"),
    ],
    targets: [
        .target(
            name: "PCMember",
            dependencies: [
                .product(name: "PCActionServiceStub", package: "PCActionService"),
                .product(name: "PCUserServiceStub", package: "PCUserService"),
                "ErrorPresenter",
                "ConfirmationPresenter",
                "ActivityPresenter",
                "MenuPresenter",
                "Raise",
                "Kingfisher"
            ]),
        .testTarget(
            name: "PCMemberTests",
            dependencies: ["PCMember"]),
    ]
)
