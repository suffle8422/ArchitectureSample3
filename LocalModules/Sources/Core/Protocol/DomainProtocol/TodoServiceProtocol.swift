//
//  TodoServiceProtocol.swift
//  LocalModules
//
//  Created by Ibuki Onishi on 2025/05/16.
//

import Foundation

package protocol TodoServiceProtocol: Actor {
    func fetch() async -> [TodoEntity]
    func insert(entity: TodoEntity) async
    func delete(id: UUID) async
    func update(entity: TodoEntity) async
}
