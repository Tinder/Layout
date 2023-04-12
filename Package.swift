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
            name: "Layout",
            plugins: [
                .plugin(name: "SwiftLintPlugin"),
            ]),
        .testTarget(
            name: "LayoutTests",
            dependencies: [
                "Layout",
                "Nimble",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ],
            plugins: [
                .plugin(name: "SwiftLintPlugin"),
            ]),
        .plugin(
            name: "SwiftLintPlugin",
            capability: .buildTool(),
            dependencies: [
                "SwiftLintBinary",
            ]),
        .binaryTarget(
            name: "SwiftLintBinary",
            url: "https://github.com/realm/SwiftLint/releases/download/0.50.3/SwiftLintBinary-macos.artifactbundle.zip",
            checksum: "abe7c0bb505d26c232b565c3b1b4a01a8d1a38d86846e788c4d02f0b1042a904"),
    ]
)
