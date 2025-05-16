//
//  TodoRepository.swift
//  LocalModules
//
//  Created by Ibuki Onishi on 2025/05/16.
//

import Foundation
import SwiftData
import Core

package final actor TodoRepository: ModelActor, TodoRepositoryProtocol {
    nonisolated package let modelExecutor: any SwiftData.ModelExecutor
    nonisolated package let modelContainer: SwiftData.ModelContainer

    package init(modelContainer: SwiftData.ModelContainer) {
        let modelContext = ModelContext(modelContainer)
        self.modelExecutor = DefaultSerialModelExecutor(modelContext: modelContext)
        self.modelContainer = modelContainer
    }

    package func fetch() -> [TodoEntity] {
        let fetchDescriptor = FetchDescriptor<TodoModel>()
        let todos = try? modelContext.fetch(fetchDescriptor)
        guard let todos else { return [] }
        return todos.map { $0.makeEntity() }
    }

    package func insert(entity: TodoEntity) {
        let todoModel = TodoModel(id: entity.id, title: entity.title, detail: entity.detail, isFinish: entity.isFinish)
        modelContext.insert(todoModel)
        try? modelContext.save()
    }

    package func delete(id: UUID) {
        guard let todo = get(id: id) else { return }
        modelContext.delete(todo)
        try? modelContext.save()
    }

    package func update(entity: TodoEntity) {
        guard let todo = get(id: entity.id) else { return }
        todo.title = entity.title
        todo.detail = entity.detail
        todo.isFinish = entity.isFinish
        try? modelContext.save()
    }

    private func get(id: UUID) -> TodoModel? {
        let fetchDescriptor = FetchDescriptor<TodoModel>(
            predicate: #Predicate { $0.id == id }
        )
        let todo = try? modelContext.fetch(fetchDescriptor).first
        return todo
    }
}
