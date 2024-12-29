import ArgumentParser
import Logging
import ServiceContextModule
import VirtualOSLogging

/**
 This command is responsible from pulling images from remote registries.
   - **Docker reference:** https://docs.docker.com/reference/cli/docker/image/pull/
 */
public struct PullCommand: AsyncParsableCommand {
    public static let configuration = CommandConfiguration(
        commandName: "pull",
        abstract: "Pulls an image from the registry"
    )

    @Flag(help: "Suppress verbose output.")
    var insecure: Bool = false

    @Argument(help: "The identifier of the image to pull")
    var image: String

    public init() {}

    public func run() async throws {
        ServiceContext.current?.logger?.info("Pulling images")
    }
}
