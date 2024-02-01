//
//  Copyright © 2024 Tinder (Match Group, LLC)
//

import Foundation
import PackagePlugin

@main
internal struct SwiftLintCommand: CommandPlugin {

    private let toolName: String = "swiftlint"

    internal func performCommand(
        context: PluginContext,
        arguments: [String]
    ) throws {
        let tool: PluginContext.Tool = try context.tool(named: toolName)
        guard !arguments.contains("--cache-path")
        else { return Diagnostics.error("Setting Cache Path Not Allowed") }
        let process: Process = .init()
        process.currentDirectoryURL = URL(fileURLWithPath: context.package.directory.string)
        process.executableURL = URL(fileURLWithPath: tool.path.string)
        process.arguments = arguments + ["--cache-path", "\(context.pluginWorkDirectory.string)"]
        try process.run()
        process.waitUntilExit()
        switch process.terminationReason {
        case .exit:
            break
        case .uncaughtSignal:
            return Diagnostics.error("Uncaught Signal")
        }
        guard process.terminationStatus == EXIT_SUCCESS
        else { return Diagnostics.error("Command Failed") }
    }
}
