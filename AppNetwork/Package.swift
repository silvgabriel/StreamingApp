// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppNetwork",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "AppNetwork", targets: ["AppNetwork"])
    ],
    targets: [
        .target(name: "AppNetwork"),
        .testTarget(name: "AppNetworkTests", dependencies: ["AppNetwork"]),
    ]
)
