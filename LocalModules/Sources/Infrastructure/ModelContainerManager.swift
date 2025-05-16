//
//  ModelContainerManager.swift
//  LocalModules
//
//  Created by Ibuki Onishi on 2025/05/16.
//

import Core
import SwiftData

package final class ModelContainerManager: ModelContainerManagerProtocol {
    package let modelContainer: ModelContainer

    package init(isInMemoryOnly: Bool = false) {
        let schema = Schema([TodoModel.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: isInMemoryOnly)
        modelContainer = try! ModelContainer(for: schema, configurations: modelConfiguration)
    }
}
