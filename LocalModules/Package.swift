// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

enum LocalModules: String, CaseIterable {
    case app = "App"
    case core = "Core"
    case coreUI = "CoreUI"
    case infrastructure = "Infrastructure"
    case domain = "Domain"
    case todoListScene = "TodoListScene"
    case todoDetailScene = "TodoDetailScene"
    
    var name: String { self.rawValue }
    
    var target: Target {
        let dependencies: [Target.Dependency]
        switch self {
        case .app:
            dependencies = LocalModules.forAppModules
        case .core:
            dependencies = []
        case .coreUI:
            dependencies = [LocalModules.core.dependency]
        case .infrastructure:
            dependencies = [LocalModules.core.dependency]
        case .domain:
            dependencies = [
                LocalModules.core.dependency,
                LocalModules.infrastructure.dependency
            ]
        case .todoListScene:
            dependencies = [
                LocalModules.core.dependency,
                LocalModules.coreUI.dependency
            ]
        case .todoDetailScene:
            dependencies = [
                LocalModules.core.dependency,
                LocalModules.coreUI.dependency
            ]
        }
        return .target(
            name: rawValue,
            dependencies: dependencies,
            path: targetPath,
            resources: resources
        )
    }
    
    var testTarget: Target? {
        guard hasTests else { return nil }
        let testName = "\(name)Tests"
        let testDependencies: [Target.Dependency] = [dependency]
        return .testTarget(name: testName, dependencies: testDependencies)
    }
    
    private var dependency: Target.Dependency {
        .target(name: rawValue)
    }
    
    private var isFeatureTarget: Bool {
        switch self {
        case .app, .core, .coreUI, .infrastructure, .domain: false
            default: true
        }
    }
    
    private var targetPath: String? {
        guard isFeatureTarget else { return nil }
        return "Sources/Features/\(name)"
    }

    private var resources: [Resource]? {
        return switch self {
        default: nil
        }
    }

    private var hasTests: Bool {
        return switch self {
        case .infrastructure, .domain: true
        default: false
        }
    }
    
    private static let forAppModules: [Target.Dependency] = LocalModules.allCases
        .filter { $0 != .app }
        .filter { $0 != .infrastructure }
        .map { $0.dependency }
}

let package = Package(
    name: "LocalModules",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "App", targets: [LocalModules.app.name]),
        .library(name: "TodoListScene", targets: [LocalModules.todoListScene.name]),
        .library(name: "TodoDetailScene", targets: [LocalModules.todoDetailScene.name]),
    ],
    targets: LocalModules.allCases.map (\.target) + LocalModules.allCases.compactMap(\.testTarget)
)
