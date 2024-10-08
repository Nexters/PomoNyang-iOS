import ProjectDescription

@_spi(Feature)
@_spi(Core)
@_spi(Domain)
@_spi(Shared)
import DependencyPlugin

let workspace = Workspace(
  name: "Mohanyang",
  projects: {
    var projects: [Path] = []
    
    projects.append(Path("Projects/App"))
    
    projects.append(Path("Projects/Feature/Feature"))
    projects += Feature.allCases.map {
      Path("Projects/\(String(describing: type(of: $0)))/\(String(describing: $0))")
    }
    
    projects.append(Path("Projects/Core/Core"))
    projects += Core.allCases.map {
      Path("Projects/\(String(describing: type(of: $0)))/\(String(describing: $0))")
    }
    
    projects.append(Path("Projects/Shared/Shared"))
    projects += Shared.allCases.map {
      Path("Projects/\(String(describing: type(of: $0)))/\(String(describing: $0))")
    }
    
    projects.append(Path("Projects/Domain/Domain"))
    projects += Domain.allCases.map {
      Path("Projects/\(String(describing: type(of: $0)))/\(String(describing: $0))")
    }
    return projects
  }(),
  generationOptions: .options(
    enableAutomaticXcodeSchemes: false,
    autogeneratedWorkspaceSchemes: .enabled(codeCoverageMode: .relevant),
    renderMarkdownReadme: true
  )
)
