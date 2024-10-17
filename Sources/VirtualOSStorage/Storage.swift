import Path
import VirtualOSStorageInterface

struct Storage: Storaging {
    func images(cacheDirectory _: AbsolutePath) async throws -> [VirtualOSStorageInterface.Image] {
        []
    }

    private func imagesDirectory(cacheDirectory: AbsolutePath) -> AbsolutePath {
        cacheDirectory.appending(component: "images")
    }
}
