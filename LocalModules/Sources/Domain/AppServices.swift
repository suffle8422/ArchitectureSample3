//
//  AppService.swift
//  LocalModules
//
//  Created by Ibuki Onishi on 2025/05/16.
//

import Infrastructure
import Core

package final class AppServices: Sendable {
    package static let shared = AppServices()
    package let modelContainerManager: any ModelContainerManagerProtocol = ModelContainerManager()
    package let todoService: any TodoServiceProtocol

    private init() {
        let todoRepository = TodoRepository(modelContainer: modelContainerManager.modelContainer)
        todoService = TodoService(todoRepository: todoRepository)
    }
}
