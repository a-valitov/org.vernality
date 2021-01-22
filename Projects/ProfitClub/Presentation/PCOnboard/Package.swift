// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PCOnboard",
    platforms: [.iOS("11.0")],
    products: [
        .library(
            name: "PCOnboard",
            targets: ["PCOnboard"]),
    ],
    dependencies: [
        .package(path: "../../Services/PCAuthentication"),
        .package(path: "../../../../Pods/Packages/ErrorPresenter"),
        .package(path: "../../../../Pods/Packages/ConfirmationPresenter"),
        .package(path: "../../../../Pods/Packages/ActivityPresenter"),
        .package(path: "../../../../Pods/Packages/Raise")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "PCOnboard",
            dependencies: [
                "PCAuthentication",
                "ErrorPresenter",
                "ConfirmationPresenter",
                "ActivityPresenter",
                "Raise"
            ]
        ),
        .testTarget(
            name: "PCOnboardTests",
            dependencies: ["PCOnboard"]),
    ]
)
