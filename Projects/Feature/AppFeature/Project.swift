import ProjectDescription
import ProjectDescriptionHelpers

@_spi(PomoNyang)
import DependencyPlugin

let project: Project = .project(
  module: PomoNyang.Feature.AppFeature,
  scripts: [],
  targets: [
    .sources(.staticLibrary),
    .interface,
    .tests,
    .testing,
    .example
  ],
  dependencies: [
    .dependency(module: PomoNyang.Domain.AppService),
    .dependency(module: PomoNyang.Shared.DesignSystem)
  ]
)
