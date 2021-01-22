// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PCModel",
    products: [
        .library(
            name: "PCModel",
            targets: ["PCModel"]),
    ],
    targets: [
        .target(
            name: "PCModel",
            dependencies: []),
        .testTarget(
            name: "PCModelTests",
            dependencies: ["PCModel"]),
    ]
)
