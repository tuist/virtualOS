# virtualOS

virtualOS is an OCI-compliant virtualization tool for macOS environments.
It builds on Apple's powerful [Virtualization](https://developer.apple.com/documentation/virtualization) framework.

## Motivation

With the [Virtualization](https://developer.apple.com/documentation/virtualization) framework, Apple made virtualization a commodity upon which organizations and businesses could develop their virtualization solutions. However, the framework is a very low-level API, and it requires a lot of work to build a virtualization solution on top of it. VirtualOS aims to provide a high-level API that resembles Docker's API and makes the solution compliant with the [OCI specification](https://github.com/opencontainers/image-spec). We developed it for some of our business products, and we are gifting this piece to the community.

## Usage

### Installation

You can install virtualOS using [Mise](https://mise.jdx.dev/):

```bash
mise install virtualos
mise use -g virtualos@latest # To activate it globally
```

Alternatively, you can [download the binary from the releases page](https://github.com/tuist/virtualOS/releases).

## Development

### Using Tuist

1. Clone the repository: `git clone https://github.com/tuist/virtualOS.git`
2. Install system dependencies: `mise install`
3. Install project dependencies: `mise run install`
2. Generate the project: `tuist generate`

## Documentation

The documentation is available at [https://virtualos.tuist.io](https://virtualos.tuist.io).
