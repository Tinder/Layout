// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "Layout",
    platforms: [
        .iOS(.v13),
        .macOS(.v12),
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
            url: "https://github.com/realm/SwiftLint.git",
            exact: "0.56.2"),
        .package(
            url: "https://github.com/Quick/Nimble.git",
            exact: "13.4.0"),
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
            exact: "1.17.4"),
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

package.targets.forEach { target in

    target.swiftSettings = [
        .enableExperimentalFeature("StrictConcurrency"),
    ]

    target.plugins = [
        .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLint"),
    ]
}
