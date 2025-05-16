//
//  ModelContainerManagerProtocol.swift
//  LocalModules
//
//  Created by Ibuki Onishi on 2025/05/16.
//

import SwiftData

package protocol ModelContainerManagerProtocol: Sendable {
    var modelContainer: ModelContainer { get }
}
