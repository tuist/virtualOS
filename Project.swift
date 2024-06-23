import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(name: "virtualOS", settings: .settings(base: ["SWIFT_STRICT_CONCURRENCY": "complete"]), targets: Module.allCases.flatMap(\.targets))
