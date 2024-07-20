import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Domain)
@_spi(Feature)
import DependencyPlugin

let project: Project = .makeTMABasedProject(
  module: Feature.AppFeature,
  scripts: [],
  targets: [
    .sources,
    .interface,
    .tests,
    .testing
  ],
  dependencies: [
    .sources: [
      .dependency(module: Domain.AppService),
    ],
    .interface: [
      .dependency(rootModule: Domain.self),
    ]
  ]
)
