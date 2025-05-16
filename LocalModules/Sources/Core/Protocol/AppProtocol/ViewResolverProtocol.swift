//
//  ViewResolverProtocol.swift
//  LocalModules
//
//  Created by Ibuki Onishi on 2025/05/16.
//

import SwiftUI

@MainActor
package protocol ViewResolverProtocol {
    func show(_ scene: AppScene) -> AnyView
}
