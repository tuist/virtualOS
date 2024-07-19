import ArgumentParser

/**
 This command is responsible from pulling images from remote registries.
   - **Docker reference:** https://docs.docker.com/reference/cli/docker/image/pull/
 */
public struct PullCommand: AsyncParsableCommand {
    public static var configuration: CommandConfiguration = .init(
        commandName: "pull",
        abstract: "Pulls an image from the registry"
    )

    public init() {}

    public func run() async throws {}
}
