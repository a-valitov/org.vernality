// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PCOrganization",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "PCOrganization",
            targets: ["PCOrganization"]),
        .library(
            name: "PCOrganizationAction",
            targets: ["PCOrganization"]),
        .library(
            name: "PCOrganizationActions",
            targets: ["PCOrganization"]),
        .library(
            name: "PCOrganizationCommercialOffer",
            targets: ["PCOrganization"]),
        .library(
            name: "PCOrganizationCommercialOffers",
            targets: ["PCOrganization"]),
        .library(
            name: "PCOrganizationMembers",
            targets: ["PCOrganization"]),
    ],
    dependencies: [
        .package(path: "../../Model/PCModel"),
        .package(path: "../../Services/PCUserService"),
        .package(path: "../../Services/PCActionService"),
        .package(path: "../../Services/PCCommercialOfferService"),
        .package(path: "../../Services/PCOrganizationService"),
        .package(path: "../../../../Pods/Packages/ErrorPresenter"),
        .package(path: "../../../../Pods/Packages/MenuPresenter"),
        .package(path: "../../../../Pods/Packages/ConfirmationPresenter"),
        .package(path: "../../../../Pods/Packages/ActivityPresenter"),
        .package(path: "../../../../Pods/Packages/Raise"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "6.0.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "PCOrganization",
            dependencies: [
                .product(name: "PCUserServiceStub", package: "PCUserService"),
                .product(name: "PCActionServiceStub", package: "PCActionService"),
                .product(name: "PCOrganizationServiceStub", package: "PCOrganizationService"),
                .product(name: "PCCommercialOfferServiceStub", package: "PCCommercialOfferService"),
                "PCModel",
                "PCUserService",
                "PCOrganizationService",
                "ErrorPresenter",
                "ConfirmationPresenter",
                "ActivityPresenter",
                "MenuPresenter",
                "Raise",
                "PCOrganizationAction",
                "PCOrganizationActions",
                "PCOrganizationCommercialOffer",
                "PCOrganizationCommercialOffers",
                "PCOrganizationMembers",
            ]),
        .target(
            name: "PCOrganizationAction",
            dependencies: [
                .product(name: "PCActionServiceStub", package: "PCActionService"),
                "ErrorPresenter",
                "ActivityPresenter",
                "Kingfisher",
            ]),
        .target(
            name: "PCOrganizationActions",
            dependencies: [
                .product(name: "PCActionServiceStub", package: "PCActionService"),
                "ErrorPresenter",
                "ActivityPresenter",
                "Kingfisher",
                "Raise",
            ]),
        .target(
            name: "PCOrganizationCommercialOffer",
            dependencies: [
                .product(name: "PCActionServiceStub", package: "PCActionService"),
                "ErrorPresenter",
                "ActivityPresenter",
                "Kingfisher",
            ]),
        .target(
            name: "PCOrganizationCommercialOffers",
            dependencies: [
                .product(name: "PCActionServiceStub", package: "PCActionService"),
                "ErrorPresenter",
                "ActivityPresenter",
                "Kingfisher",
                "Raise",
            ]),
        .target(
            name: "PCOrganizationMembers",
            dependencies: [
                .product(name: "PCActionServiceStub", package: "PCActionService"),
                "ErrorPresenter",
                "ActivityPresenter",
                "Kingfisher",
            ]),
        .testTarget(
            name: "PCOrganizationTests",
            dependencies: ["PCOrganization"]),
    ]
)
