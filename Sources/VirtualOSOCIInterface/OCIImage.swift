import Foundation

/// Defines the [OCI Image Schema](https://github.com/opencontainers/image-spec/blob/main/manifest.md) in Swift.
public struct OCIImage: Codable {
    /// Specifies the manifest schema version.
    /// It must be 2 to ensure backward compatible with older Docker versions.
    public var schemaVersion: Int

    /// It contains the media type `application/vnd.oci.image.manifest.v1+json`
    public var mediaType: String

    /// Contains the artifact type when the manifest is used as an artifact.
    public var artifactType: String?

    /// References a configuration object for a container, by digest.
    /// Some important notes:
    ///   - The referenced content should not be parsed if this media type is unknown and instead considered the referenced
    /// content as arbitrary binary data (e.g., `application/octet-stream`). The implementations should support at least
    /// `application/vnd.oci.image.config.v1+json`.
    ///
    public var config: OCIContentDescriptor

    /// It contains the image layers. For portability, layers should contain at least one item.
    ///  - When `config.mediaType` is `application/vnd.oci.image.config.v1+json`:
    ///    - The array must have the base layer at index 0.
    ///    - Subsequent layers must follow in stack order.
    ///    - The final filesystem layout must match the result of applying the layers to an empty directory.
    ///    - The ownership, mode, and other attributes of the initial empty directory are unspecified.
    ///  - The `mediaType` of layers must support at least one of the following types.
    ///   - `application/vnd.oci.image.layer.v1.tar`
    ///   - `application/vnd.oci.image.layer.v1.tar+gzip`
    ///   - `application/vnd.oci.image.layer.nondistributable.v1.tar`
    ///   - `application/vnd.oci.image.layer.nondistributable.v1.tar+gzip`
    public var layers: [OCIContentDescriptor]

    /// Specifies a descriptor of another manifest.
    /// It defines a weak association to a separate Merkle Directed Acyclic Graph (DAG),
    /// and is used by the referrers API to include this manifest in the list of responses for the subject digest.
    public var subject: OCIContentDescriptor?

    /// Contains arbitrary metadata for the image manifest.
    public var annotations: [String: String]?
}
