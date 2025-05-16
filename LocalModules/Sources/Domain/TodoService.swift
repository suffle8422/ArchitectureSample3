//
//  TodoService.swift
//  LocalModules
//
//  Created by Ibuki Onishi on 2025/05/16.
//

import Foundation
import Core
import Infrastructure

actor TodoService: TodoServiceProtocol {
    private let todoRepository: any TodoRepositoryProtocol

    init(todoRepository: any TodoRepositoryProtocol) {
        self.todoRepository = todoRepository
    }

    func fetch() async -> [TodoEntity] {
        await todoRepository.fetch()
    }

    func insert(entity: TodoEntity) async {
        await todoRepository.insert(entity: entity)
    }

    func delete(id: UUID) async {
        await todoRepository.delete(id: id)
    }

    func update(entity: TodoEntity) async {
        await todoRepository.update(entity: entity)
    }
}
