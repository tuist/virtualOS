import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(name: "macker", targets: Module.allCases.flatMap(\.targets))
