//
//  TodoDetailSceneState.swift
//  LocalModules
//
//  Created by Ibuki Onishi on 2025/05/16.
//

import SwiftUI
import Observation
import Core

@MainActor
@Observable
package final class TodoDetailSceneState {
    @ObservationIgnored let todoService: any TodoServiceProtocol
    var model: TodoEntity

    var isShownDeleteAlert = false

    package init(
        model: TodoEntity,
        todoService: any TodoServiceProtocol
    ) {
        self.model = model
        self.todoService = todoService
    }

    func toggleFinishFlg() async {
        let updatedTodo = TodoEntity(
            id: model.id,
            title: model.title,
            detail: model.detail,
            isFinish: !model.isFinish
        )
        await todoService.update(entity: updatedTodo)
        model = updatedTodo
    }

    func deleteTodo() async {
        await todoService.delete(id: model.id)
    }
}
