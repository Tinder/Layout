// swift-tools-version:5.10

import PackageDescription

let packageName = "Layout"

enum SwiftLint {
    static let plugin = "SwiftLintPlugin-\(packageName)"
    static let binary = "SwiftLintBinary-\(packageName)"
}

let package = Package(
    name: packageName,
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
            from: "13.0.0"),
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
            from: "1.15.0"),
    ],
    targets: [
        .target(
            name: "Layout",
            swiftSettings: .swiftSettings,
            plugins: [
                .plugin(name: SwiftLint.plugin),
            ]),
        .testTarget(
            name: "LayoutTests",
            dependencies: [
                "Layout",
                "Nimble",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ],
            exclude: [
                "__Snapshots__",
                "UIKit/__Snapshots__",
            ],
            swiftSettings: .swiftSettings,
            plugins: [
                .plugin(name: SwiftLint.plugin),
            ]),
        .plugin(
            name: "SwiftLintCommand",
            capability: .command(intent: .custom(verb: "swiftlint", description: "SwiftLint Command Plugin")),
            dependencies: [
                .target(name: SwiftLint.binary)
            ]),
        .plugin(
            name: SwiftLint.plugin,
            capability: .buildTool(),
            dependencies: [
                .target(name: SwiftLint.binary)
            ],
            path: "Plugins/SwiftLintPlugin"),
        .binaryTarget(
            name: SwiftLint.binary,
            url: "https://github.com/realm/SwiftLint/releases/download/0.54.0/SwiftLintBinary-macos.artifactbundle.zip",
            checksum: "963121d6babf2bf5fd66a21ac9297e86d855cbc9d28322790646b88dceca00f1"),
    ]
)

extension Array where Element == SwiftSetting {

    static var swiftSettings: [SwiftSetting] {
        [
            .enableExperimentalFeature("StrictConcurrency"),
        ]
    }
}
