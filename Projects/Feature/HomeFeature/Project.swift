import ProjectDescription
import ProjectDescriptionHelpers

@_spi(Feature)
@_spi(Domain)
import DependencyPlugin

let project: Project = .makeTMABasedProject(
  module: Feature.HomeFeature,
  scripts: [],
  targets: [
    .sources,
    .tests,
    .testing,
    .example
  ],
  dependencies: [
    .sources: [
      .dependency(rootModule: Domain.self),
      .dependency(module: Feature.MyPageFeature),
      .dependency(module: Feature.PomodoroFeature)
    ]
  ]
)
