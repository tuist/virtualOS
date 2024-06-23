import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(name: "virtualOS", targets: Module.allCases.flatMap(\.targets))
