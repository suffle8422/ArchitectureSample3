//
//  TodoModel.swift
//  LocalModules
//
//  Created by Ibuki Onishi on 2025/05/16.
//

import Foundation
import SwiftData
import Core

@Model
class TodoModel {
    @Attribute(.unique) var id: UUID
    var title: String
    var detail: String
    var isFinish: Bool

    init(
        id: UUID,
        title: String,
        detail: String,
        isFinish: Bool = false
    ) {
        self.id = id
        self.title = title
        self.detail = detail
        self.isFinish = isFinish
    }

    func makeEntity() -> TodoEntity {
        return TodoEntity(
            id: id,
            title: title,
            detail: detail,
            isFinish: isFinish
        )
    }
}
