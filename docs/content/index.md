---
title: "virtualOS - Virtualized macOS environments"
titleTemplate: :title
---

# virtualOS

In November 2020, Apple introduced the [Virtualization framework](https://developer.apple.com/documentation/virtualization), which provides a high-level API for creating and managing virtual machines.
This technology brought us closer to having a [Docker](https://www.docker.com/)-like experience for macOS, where we can run macOS environments in isolation, but lacked a user-friendly CLI-based interface to manage and run these virtual machines.

virtualOS is a CLI tool that aims to provide a user-friendly interface to manage and run virtual machines on macOS using the Virtualization framework. It aligns with the Docker CLI interface for familiarity, and embraces the OCI image format to define the virtual machine images.

## Installation

You can install virtualOS using [Mise](https://mise.jdx.dev/):

```bash
mise install virtualos
mise use -g virtualos@latest # To activate it globally
```

Alternatively, you can [download the binary from the releases page](https://github.com/tuist/virtualOS/releases).

> [!WARNING] WORK IN PROGRESS
> virtualOS is a work in progress. We are actively working on it, and we are looking for contributors to help us build it. If you are interested, you can grab one of the issues labeled as `good first issue` and start contributing.
