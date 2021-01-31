// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BundleUtils",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "BundleUtils",
            targets: ["BundleUtils"]),
    ],
    targets: [
        .target(
            name: "BundleUtils",
            dependencies: []),
        .testTarget(
            name: "BundleUtilsTests",
            dependencies: ["BundleUtils"]),
    ]
)
