// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Layout",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "Layout",
            targets: ["Layout"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/Quick/Nimble.git",
            from: "11.2.0"),
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
            from: "1.11.0"),
    ],
    targets: [
        .target(
            name: "Layout"),
        .testTarget(
            name: "LayoutTests",
            dependencies: [
                "Layout",
                "Nimble",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]),
    ]
)
