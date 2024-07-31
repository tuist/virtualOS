import VirtualOSStorageInterface
import Path

struct Storage: Storaging {
    func images(cacheDirectory: AbsolutePath) async throws -> [VirtualOSStorageInterface.Image] {
        return []
    }
    
    private func imagesDirectory(cacheDirectory: AbsolutePath) -> AbsolutePath {
        return cacheDirectory.appending(component: "images")
    }
    
}
