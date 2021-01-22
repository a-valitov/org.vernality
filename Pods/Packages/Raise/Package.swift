// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Raise",
    platforms: [.iOS("11.0")],
    products: [
        .library(
            name: "Raise",
            targets: ["Raise"]),
    ],
    dependencies: [
        .package(url: "https://github.com/gordontucker/FittedSheets", from: "2.2.3"),
    ],
    targets: [
        .target(
            name: "Raise",
            dependencies: ["FittedSheets"]),
        .testTarget(
            name: "RaiseTests",
            dependencies: ["Raise"]),
    ]
)
