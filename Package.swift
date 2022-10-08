// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NightAndRadiance",
    products: [
        .library(
            name: "NightAndRadiance",
            targets: ["NightAndRadiance"]),
        .executable(
            name: "night_and_radiance",
            targets: ["NightAndRadiance"])
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "NightAndRadiance",
            dependencies: []),
//        .testTarget(
//            name: "NightAndRadianceTests",
//            dependencies: ["NightAndRadiance"]),
    ]
)
