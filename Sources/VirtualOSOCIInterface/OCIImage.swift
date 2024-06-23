import Foundation

/// Defines the [OCI Image Schema](https://github.com/opencontainers/image-spec/blob/main/manifest.md) in Swift.
public struct OCIImage {
    /// Specifies the manifest schema version.
    /// It must be 2 to ensure backward compatible with older Docker versions.
    public var schemaVersion: Int

    /// It contains the media type `application/vnd.oci.image.manifest.v1+json`
    public var mediaType: String

    /// Contains the artifact type when the manifest is used as an artifact.
    public var artifactType: String?

    /// References a configuration object for a container, by digest.
    public var config: OCIContentDescriptor

    /// Specifies a descriptor of another manifest.
    /// It defines a weak association to a separate Merkle Directed Acyclic Graph (DAG),
    /// and is used by the referrers API to include this manifest in the list of responses for the subject digest.
    public var subject: OCIContentDescriptor?

    /// Contains arbitrary metadata for the image manifest.
    public var annotations: [String: String]?
}
