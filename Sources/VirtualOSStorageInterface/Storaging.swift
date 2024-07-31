import Foundation
import Path

public protocol Storaging {
    func images(cacheDirectory: AbsolutePath) async throws -> [Image]
}
