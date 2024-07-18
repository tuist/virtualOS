import ArgumentParser

/**
 This command is responsible from pulling images from remote registries.
   - **Docker reference:** https://docs.docker.com/reference/cli/docker/image/run/
 */
public struct RunCommand: AsyncParsableCommand {
    public static var configuration: CommandConfiguration = .init(
        commandName: "run",
        abstract: "Runs an image"
    )

    public init() {}

    @Argument(help: "The phrase to repeat.")
    public var image: String

    public func run() async throws {}
}
