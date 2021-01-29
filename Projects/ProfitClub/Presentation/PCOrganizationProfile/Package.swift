// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PCOrganizationProfile",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "PCOrganizationProfile",
            targets: ["PCOrganizationProfile"]),
    ],
    dependencies: [
        .package(path: "../../../../Pods/Packages/ErrorPresenter"),
        .package(path: "../../../../Pods/Packages/ActivityPresenter"),
        .package(path: "../../Services/PCOrganizationService"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "6.0.1"),
    ],
    targets: [
        .target(
            name: "PCOrganizationProfile",
            dependencies: [
                "ActivityPresenter",
                "ErrorPresenter",
                "Kingfisher",
                .product(name: "PCOrganizationServiceStub", package: "PCOrganizationService"),
            ]),
        .testTarget(
            name: "PCOrganizationProfileTests",
            dependencies: ["PCOrganizationProfile"]),
    ]
)
