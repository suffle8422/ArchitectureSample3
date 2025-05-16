//
//  TodoListSceneState.swift
//  LocalModules
//
//  Created by Ibuki Onishi on 2025/05/16.
//

import Foundation
import Observation
import Core

@MainActor
@Observable
package final class TodoListSceneState {
    @ObservationIgnored let viewResolver: any ViewResolverProtocol
    @ObservationIgnored let todoService: any TodoServiceProtocol
    var todos = [TodoEntity]()

    package init(
        viewResolver: any ViewResolverProtocol,
        todoService: any TodoServiceProtocol
    ) {
        self.viewResolver = viewResolver
        self.todoService = todoService
    }

    func fetchTodos() async {
        todos = await todoService.fetch()
    }

    func insertTodo() async {
        let todo = TodoEntity(
            id: UUID(),
            title: Date().formattedString,
            detail: "詳細情報",
            isFinish: false
        )
        await todoService.insert(entity: todo)
        todos = await todoService.fetch()
    }
}
