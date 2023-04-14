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
            url: "https://github.com/realm/SwiftLint/releases/download/0.51.0/SwiftLintBinary-macos.artifactbundle.zip",
            checksum: "9fbfdf1c2a248469cfbe17a158c5fbf96ac1b606fbcfef4b800993e7accf43ae"),
    ]
)
