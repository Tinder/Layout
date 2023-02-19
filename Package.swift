// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Layout",
    platforms: [
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "Layout",
            targets: ["Layout"]),
    ],
    targets: [
        .target(
            name: "Layout"),
        .testTarget(
            name: "LayoutTests",
            dependencies: [
                "Layout",
            ]),
    ]
)
