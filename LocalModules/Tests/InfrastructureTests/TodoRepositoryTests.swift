//
//  TodoRepositoryTests.swift
//  LocalModules
//
//  Created by Ibuki Onishi on 2025/05/16.
//

import Foundation
import Testing
@testable import Core
@testable import Infrastructure

actor TodoRepositoryTests {
    private let todoRepository: any TodoRepositoryProtocol = TodoRepository(modelContainer: ModelContainerManager(isInMemoryOnly: true).modelContainer)
    
    @Test
    func fetch() async {
        await todoRepository.setTestTodos()
        let fetchedTodos = await todoRepository.fetch()
        #expect(fetchedTodos.count == 10)
    }
    
    @Test
    func insert() async {
        let todosBeforeInserting = await todoRepository.fetch()
        #expect(todosBeforeInserting.count == 0)
        
        let todo = TodoEntity(
            id: UUID(),
            title: "タイトル1",
            detail: "詳細1",
            isFinish: false
        )
        await todoRepository.insert(entity: todo)
        
        let todosAfterInserting = await todoRepository.fetch()
        #expect(todosAfterInserting.count == 1)
    }
    
    @Test
    func update() async throws {
        let id = UUID()
        let todo1 = TodoEntity(
            id: id,
            title: "タイトル1",
            detail: "詳細1",
            isFinish: false
        )
        await todoRepository.insert(entity: todo1)
        
        let todosBeforeUpdating = await todoRepository.fetch()
        #expect(todosBeforeUpdating.count == 1)
        
        let todo2 = TodoEntity(
            id: id,
            title: "タイトル2",
            detail: "詳細2",
            isFinish: false
        )
        await todoRepository.update(entity: todo2)
        
        let todosAfterUpdating = await todoRepository.fetch()
        #expect(todosAfterUpdating.count == 1, "update後もTODOが1件")
        
        let targetTodo = try #require(todosAfterUpdating.first)
        #expect(targetTodo.title == "タイトル2")
        #expect(targetTodo.detail == "詳細2")
    }
}

private extension TodoRepositoryProtocol {
    func setTestTodos() async {
        for index in 1...10 {
            let todo = TodoEntity(
                id: UUID(),
                title: "タイトル\(index)",
                detail: "詳細\(index)",
                isFinish: false
            )
            await insert(entity: todo)
        }
    }
}
