//
//  TodoEntity.swift
//  LocalModules
//
//  Created by Ibuki Onishi on 2025/05/16.
//

import Foundation

package struct TodoEntity: Sendable, Hashable {
    package let id: UUID
    package let title: String
    package let detail: String
    package let isFinish: Bool
    
    package init(id: UUID, title: String, detail: String, isFinish: Bool) {
        self.id = id
        self.title = title
        self.detail = detail
        self.isFinish = isFinish
    }
}
