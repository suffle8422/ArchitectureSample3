//
//  TopScene.swift
//  LocalModules
//
//  Created by Ibuki Onishi on 2025/05/16.
//

import SwiftUI
import SwiftData
import Core
import Domain

public struct TopScene: View {
    public init() {}

    public var body: some View {
        ViewResolver.shared.show(AppScene.todoListScene)
            .modelContainer(AppServices.shared.modelContainerManager.modelContainer)
    }
}
