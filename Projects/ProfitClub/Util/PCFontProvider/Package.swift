// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PCFontProvider",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "PCFontProvider",
            targets: ["PCFontProvider"]
        ),
    ],
    targets: [
        .target(
            name: "PCFontProvider",
            dependencies: [],
            resources: [.process("Fonts")]),
        .testTarget(
            name: "PCFontProviderTests",
            dependencies: ["PCFontProvider"]),
    ]
)
