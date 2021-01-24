// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PCReview",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "PCReview",
            targets: ["PCReview"]),
    ],
    dependencies: [
        .package(path: "../../Model/PCModel"),
        .package(path: "../../Services/PCUserService"),
        .package(path: "../../../../Pods/Packages/ErrorPresenter"),
        .package(path: "../../../../Pods/Packages/ConfirmationPresenter"),
        .package(path: "../../../../Pods/Packages/ActivityPresenter"),
        .package(path: "../../../../Pods/Packages/MenuPresenter"),
    ],
    targets: [
        .target(
            name: "PCReview",
            dependencies: [
                .product(name: "PCUserServiceStub", package: "PCUserService"),
                "PCModel",
                "ErrorPresenter",
                "ConfirmationPresenter",
                "ActivityPresenter",
                "MenuPresenter"
            ]),
        .testTarget(
            name: "PCReviewTests",
            dependencies: ["PCReview"]),
    ]
)
