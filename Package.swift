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
        .library(
            name: "SnapshotTestingExtensions",
            targets: ["SnapshotTestingExtensions"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/Quick/Nimble.git",
            from: "13.0.0"),
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
            from: "1.15.0"),
    ],
    targets: [
        .target(
            name: "Layout"),
        .target(
            name: "SnapshotTestingExtensions",
            dependencies: [
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]),
        .testTarget(
            name: "LayoutTests",
            dependencies: [
                "Layout",
                "SnapshotTestingExtensions",
                "Nimble",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ],
            exclude: [
                "__Snapshots__",
                "UIKitTests/__Snapshots__",
            ]),
    ]
)
