import ArgumentParser
import FileSystem
import Foundation
import Logging
import Path
import ServiceContextModule
import VirtualOSEnvironment
import VirtualOSEnvironmentInterface
import VirtualOSLogging

@main
private enum VirtualOS {
    static func main() async throws {
        let fileSystem = FileSystem()
        let environment = try await Environment.current()
        let logFilePath = environment.cacheDirectory.appending(components: ["logs", "\(UUID().uuidString).log"])
        if try await !fileSystem.exists(logFilePath.parentDirectory) {
            try await fileSystem.makeDirectory(at: logFilePath.parentDirectory)
        }
        let logger = Logger.makeDefaultLogger(logFilePath: logFilePath)
        var serviceContext = ServiceContext.topLevel
        serviceContext.logger = logger
        serviceContext.environment = environment

        await ServiceContext.$current.withValue(serviceContext) {
            defer {
                showCompletion(logFilePath: logFilePath)
            }

            do {
                var command = try VirtualOSCommand.parseAsRoot()
                if var asyncCommand = command as? AsyncParsableCommand {
                    try await asyncCommand.run()
                } else {
                    try command.run()
                }
            } catch {
                showCompletion(logFilePath: logFilePath)
                VirtualOSCommand.exit(withError: error)
            }
        }
    }

    private static func showCompletion(logFilePath: AbsolutePath) {
        if !CommandLine.arguments.contains("--help"), !CommandLine.arguments.contains("-h") {
            print("Logs available at: \(logFilePath.pathString)")
        }
    }
}
