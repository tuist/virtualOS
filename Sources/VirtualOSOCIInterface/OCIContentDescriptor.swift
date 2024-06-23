import Foundation

/// Content descriptors, or simply descriptors, declare references between the components
/// in the Merkle Directed Acyclic Graph (DAG).
public struct OCIContentDescriptor: Codable {
    /// Describes the media type of the referenced content.
    /// The value must complain with [RFC6838](https://tools.ietf.org/html/rfc6838)
    public var mediaType: String

    /// It represents the digest of the targeted content.
    /// Any retrieved content from untrusted sources should be verified against this digest.
    public var digest: String

    /// Specifies the size in bytes of the raw content.
    /// The client should use this to check the size before doing further validations like digest validation.
    public var size: Int64

    /// Specifies a list of URLs from where the referred content might be downloaded.
    /// URLs must conform to [RFC3986](https://tools.ietf.org/html/rfc3986) and should use
    /// either the `http` or the `https` schemes.
    public var urls: [URL]?

    /// Contains arbitrary metadata.
    public var annotations: [String: String]?

    /// Contains an embedded representation of the referenced content.
    /// The value must conform to  the [Base 64](https://tools.ietf.org/html/rfc4648#section-4) encoding.
    public var data: String?

    /// Contains the type of an artifact when the descriptor points to an artifact.
    /// This is the value of the config descriptor `mediaType` when the descriptor references an image manifest.
    /// The value must conform to [RFC6838](https://tools.ietf.org/html/rfc6838)
    public var artifactType: String?
}
