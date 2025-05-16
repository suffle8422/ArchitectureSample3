//
//  ViewResolver.swift
//  LocalModules
//
//  Created by Ibuki Onishi on 2025/05/16.
//

import SwiftUI
import Core
import CoreUI
import Domain
import TodoListScene
import TodoDetailScene

final class ViewResolver: ViewResolverProtocol {
    static let shared: any ViewResolverProtocol = ViewResolver()
    private init() {}
    
    func show(_ scene: AppScene) -> AnyView {
        let sceneView = makeSceneView(scene)
        return AnyView(sceneView)
    }

    private func makeSceneView(_ scene: AppScene) -> any View {
        switch scene {
        case .todoListScene:
            let state = TodoListSceneState(
                viewResolver: self,
                todoService: AppServices.shared.todoService
            )
            return buildView(TodoListScene(state: state))
        case .todoDetailScene(let entity):
            let state = TodoDetailSceneState(
                model: entity,
                todoService: AppServices.shared.todoService
            )
            return buildView(TodoDetailScene(state: state))
        }
    }

    private func buildView<Content: View>(_ content: Content) -> some View {
        LazyView(
            ZStack {
                Color.white
                    .ignoresSafeArea(edges: [.bottom])
                content
            }
        )

    }
}
