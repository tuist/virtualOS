import ArgumentParser
import Foundation
import VirtualOSPull
import VirtualOSRun

struct VirtualOSCommand: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "virtualos",
        abstract: "Virtualized macOS environments",
        subcommands: [PullCommand.self, RunCommand.self]
    )
}
