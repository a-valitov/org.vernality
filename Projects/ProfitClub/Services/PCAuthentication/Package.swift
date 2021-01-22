// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PCAuthentication",
    products: [
        .library(
            name: "PCAuthentication",
            targets: ["PCAuthentication"]),
        .library(
            name: "PCAuthenticationStub",
            targets: ["PCAuthenticationStub"]),
    ],
    dependencies: [
        .package(path: "../../Model/PCModel"),
    ],
    targets: [
        .target(
            name: "PCAuthentication",
            dependencies: ["PCModel"]),
        .target(
            name: "PCAuthenticationStub",
            dependencies: ["PCModel", "PCAuthentication"]),
        .testTarget(
            name: "PCAuthenticationTests",
            dependencies: ["PCAuthentication"]),
    ]
)
