//
//  Copyright © 2023 Tinder (Match Group, LLC)
//

import Foundation
import PackagePlugin

@main
internal struct SwiftLintPlugin: BuildToolPlugin {

    internal enum SwiftLintPluginError: Error, CustomStringConvertible {

        case swiftFilesNotInProjectDirectory(Path)
        case swiftFilesNotInWorkingDirectory(Path)

        internal var description: String {
            switch self {
            case let .swiftFilesNotInProjectDirectory(directory):
                return """
                    Swift files are not in project directory.
                    Directory: \(directory)
                    """
            case let .swiftFilesNotInWorkingDirectory(directory):
                return """
                    Swift files are not in working directory.
                    Directory: \(directory)
                    """
            }
        }
    }

    internal func createBuildCommands(
        context: PluginContext,
        target: Target
    ) async throws -> [Command] {
        try makeCommand(executable: context.tool(named: "swiftlint"),
                        swiftFiles: (target as? SourceModuleTarget).flatMap(swiftFiles) ?? [],
                        environment: environment(context: context, target: target),
                        pluginWorkDirectory: context.pluginWorkDirectory)
    }

    /// Collects the paths of the Swift files to be linted.
    private func swiftFiles(target: SourceModuleTarget) -> [Path] {
        target
            .sourceFiles(withSuffix: "swift")
            .map(\.path)
    }

    /// Creates an environment dictionary containing a value for the `BUILD_WORKSPACE_DIRECTORY` key.
    ///
    /// This method locates the topmost `.swiftlint.yml` config file within the package directory for this target
    /// and sets the config file's containing directory as the `BUILD_WORKSPACE_DIRECTORY` value. The package
    /// directory is used if a config file is not found.
    ///
    /// The `BUILD_WORKSPACE_DIRECTORY` environment variable controls SwiftLint's working directory.
    ///
    /// Reference: [https://github.com/realm/SwiftLint/blob/0.50.3/Source/swiftlint/Commands/SwiftLint.swift#L7](
    /// https://github.com/realm/SwiftLint/blob/0.50.3/Source/swiftlint/Commands/SwiftLint.swift#L7
    /// )
    private func environment(
        context: PluginContext,
        target: Target
    ) throws -> [String: String] {

        let workingDirectory: Path = try target.directory.resolveWorkingDirectory(in: context.package.directory)

        return ["BUILD_WORKSPACE_DIRECTORY": "\(workingDirectory)"]
    }

    private func makeCommand(
        executable: PluginContext.Tool,
        swiftFiles: [Path],
        environment: [String: String],
        pluginWorkDirectory path: Path
    ) -> [Command] {

        print("Environment:", environment)

        let arguments: [String] = ["lint", "--quiet", "--force-exclude", "--cache-path", "\(path)"]

        return swiftFiles.isEmpty ? [] : [
            .prebuildCommand(
                displayName: "SwiftLint",
                executable: executable.path,
                arguments: arguments + swiftFiles.map(\.string),
                environment: environment,
                outputFilesDirectory: path.appending("Output"))
        ]
    }
}

#if canImport(XcodeProjectPlugin)

import XcodeProjectPlugin

// swiftlint:disable:next no_grouping_extension
extension SwiftLintPlugin: XcodeBuildToolPlugin {

    internal func createBuildCommands(
        context: XcodePluginContext,
        target: XcodeTarget
    ) throws -> [Command] {
        try makeCommand(executable: context.tool(named: "swiftlint"),
                        swiftFiles: swiftFiles(target: target),
                        environment: environment(context: context, target: target),
                        pluginWorkDirectory: context.pluginWorkDirectory)
    }

    /// Collects the paths of the Swift files to be linted.
    private func swiftFiles(target: XcodeTarget) -> [Path] {
        target
            .inputFiles
            .filter { $0.type == .source && $0.path.extension == "swift" }
            .map(\.path)
    }

    /// Creates an environment dictionary containing a value for the `BUILD_WORKSPACE_DIRECTORY` key.
    ///
    /// This method locates the topmost `.swiftlint.yml` config file within the project directory for this target's
    /// Swift source files and sets the config file's containing directory as the `BUILD_WORKSPACE_DIRECTORY` value.
    /// The project directory is used if a config file is not found.
    ///
    /// The `BUILD_WORKSPACE_DIRECTORY` environment variable controls SwiftLint's working directory.
    ///
    /// Reference: [https://github.com/realm/SwiftLint/blob/0.50.3/Source/swiftlint/Commands/SwiftLint.swift#L7](
    /// https://github.com/realm/SwiftLint/blob/0.50.3/Source/swiftlint/Commands/SwiftLint.swift#L7
    /// )
    private func environment(
        context: XcodePluginContext,
        target: XcodeTarget
    ) throws -> [String: String] {

        let projectDirectory: Path = context.xcodeProject.directory
        let swiftFiles: [Path] = swiftFiles(target: target)
        let swiftFilesNotInProjectDirectory: [Path] = swiftFiles.filter { !$0.isDescendant(of: projectDirectory) }

        guard swiftFilesNotInProjectDirectory.isEmpty
        else { throw SwiftLintPluginError.swiftFilesNotInProjectDirectory(projectDirectory) }

        let directories: [Path] = try swiftFiles.map { try $0.resolveWorkingDirectory(in: projectDirectory) }
        let workingDirectory: Path = directories.min { $0.depth < $1.depth } ?? projectDirectory
        let swiftFilesNotInWorkingDirectory: [Path] = swiftFiles.filter { !$0.isDescendant(of: workingDirectory) }

        guard swiftFilesNotInWorkingDirectory.isEmpty
        else { throw SwiftLintPluginError.swiftFilesNotInWorkingDirectory(workingDirectory) }

        return ["BUILD_WORKSPACE_DIRECTORY": "\(workingDirectory)"]
    }
}

#endif

extension Path {

    internal enum PathError: Error, CustomStringConvertible {

        case pathNotInDirectory(path: Path, directory: Path)

        internal var description: String {
            switch self {
            case let .pathNotInDirectory(path, directory):
                return """
                    Path is not in directory.
                    Path: \(path)
                    Directory: \(directory)
                    """
            }
        }
    }

    internal var directoryContainsConfigFile: Bool {
        FileManager.default.fileExists(atPath: "\(self)/.swiftlint.yml")
    }

    internal var depth: Int {
        URL(fileURLWithPath: "\(self)").pathComponents.count
    }

    internal func isDescendant(of path: Path) -> Bool {
        "\(self)".hasPrefix("\(path)")
    }

    internal func resolveWorkingDirectory(in directory: Path) throws -> Path {

        guard "\(self)".hasPrefix("\(directory)")
        else { throw PathError.pathNotInDirectory(path: self, directory: directory) }

        let path: Path? = sequence(first: self) { path in
            let path: Path = path.removingLastComponent()
            guard "\(path)".hasPrefix("\(directory)")
            else { return nil }
            return path
        }
        .reversed()
        .first(where: \.directoryContainsConfigFile)

        return path ?? directory
    }
}
