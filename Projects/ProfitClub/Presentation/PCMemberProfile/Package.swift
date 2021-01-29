// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PCMemberProfile",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "PCMemberProfile",
            targets: ["PCMemberProfile"]),
    ],
    dependencies: [
        .package(path: "../../../../Pods/Packages/ErrorPresenter"),
        .package(path: "../../../../Pods/Packages/ActivityPresenter"),
        .package(path: "../../Services/PCUserService"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "6.0.1"),
    ],
    targets: [
        .target(
            name: "PCMemberProfile",
            dependencies: [
                "ActivityPresenter",
                "ErrorPresenter",
                "Kingfisher",
                .product(name: "PCUserServiceStub", package: "PCUserService"),
            ]),
        .testTarget(
            name: "PCMemberProfileTests",
            dependencies: ["PCMemberProfile"]),
    ]
)
