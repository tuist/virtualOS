import ArgumentParser
import Foundation
import MackerPull
import MackerRun

@main
struct MackerCommand: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "macker",
        abstract: "Virtualized macOS environments",
        subcommands: [PullCommand.self, RunCommand.self]
    )
}
