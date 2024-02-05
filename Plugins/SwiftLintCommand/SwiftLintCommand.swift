//
//  All Contributions by Match Group
//
//  Copyright © 2024 Tinder (Match Group, LLC)
//
//  Licensed under the Match Group Modified 3-Clause BSD License.
//  See https://github.com/Tinder/Layout/blob/main/LICENSE for license information.
//

import Foundation
import PackagePlugin

@main
internal struct SwiftLintCommand: CommandPlugin {

    internal func performCommand(
        context: PluginContext,
        arguments: [String]
    ) throws {
        let tool: PluginContext.Tool = try context.tool(named: "swiftlint")
        guard !arguments.contains("--cache-path")
        else { return Diagnostics.error("Setting Cache Path Not Allowed") }
        let process: Process = .init()
        process.currentDirectoryURL = URL(fileURLWithPath: context.package.directory.string)
        process.executableURL = URL(fileURLWithPath: tool.path.string)
        if arguments.contains("analyze") {
            process.arguments = arguments
        } else {
            process.arguments = arguments + ["--cache-path", "\(context.pluginWorkDirectory.string)"]
        }
        try process.run()
        process.waitUntilExit()
        switch process.terminationReason {
        case .exit:
            break
        case .uncaughtSignal:
            return Diagnostics.error("Uncaught Signal")
        @unknown default:
            return Diagnostics.error("Unexpected Termination Reason")
        }
        guard process.terminationStatus == EXIT_SUCCESS
        else { return Diagnostics.error("Command Failed") }
    }
}
