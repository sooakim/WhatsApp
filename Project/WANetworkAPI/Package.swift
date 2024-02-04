// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WANetworkAPI",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "WANetworkAPI",
            type: .dynamic,
            targets: ["WANetworkAPI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.3")),
        .package(url: "https://github.com/SwiftyLab/MetaCodable.git", .upToNextMajor(from: "1.0.0")),
        .package(name: "WAFoundation", path: "../WAFoundation")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "WANetworkAPI",
            dependencies: [
                .product(name: "CombineMoya", package: "Moya"),
                .product(name: "MetaCodable", package: "MetaCodable"),
                .product(name: "WAFoundation", package: "WAFoundation")
            ]
        ),
        .testTarget(
            name: "WANetworkAPITests",
            dependencies: ["WANetworkAPI"]),
    ]
)
