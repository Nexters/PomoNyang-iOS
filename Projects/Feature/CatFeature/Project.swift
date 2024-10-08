import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Feature)
@_spi(Domain)
import DependencyPlugin

let project: Project = .makeTMABasedProject(
  module: Feature.CatFeature,
  scripts: [],
  targets: [
    .sources,
    .tests,
    .testing
  ],
  dependencies: [
    .sources: [
      .dependency(rootModule: Domain.self)
    ],
  ]
)
