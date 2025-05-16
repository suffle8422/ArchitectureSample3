//
//  TodoDetailScene.swift
//  LocalModules
//
//  Created by Ibuki Onishi on 2025/05/16.
//

import SwiftUI
import Core

package struct TodoDetailScene: View {
    @State var state: TodoDetailSceneState
    @Environment(\.dismiss) private var dismiss

    package init(state: TodoDetailSceneState) {
        self.state = state
    }
    
    package var body: some View {
        VStack {
            modelInfoView(model: state.model)
            Button(
                action: {
                    Task { await state.toggleFinishFlg() }
                },
                label: {
                    Text(state.model.isFinish ? "未完了" : "完了")
                }
            )
        }
        .navigationTitle("todo詳細")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(
                    action: { state.isShownDeleteAlert = true },
                    label: { Image(systemName: "trash") }
                )
            }
        }
        .alert("",isPresented: $state.isShownDeleteAlert) {
            Button(
                role: .cancel,
                action: {},
                label: { Text("キャンセル") }
            )
            Button(
                role: .destructive,
                action: {
                    Task {
                        await state.deleteTodo()
                        dismiss()
                    }
                },
                label: { Text("削除") }
            )
        } message: {
            Text("このTODOを削除します\nよろしいですか")
        }
    }
}

private extension TodoDetailScene {
    func modelInfoView(model: TodoEntity) -> some View {
        VStack {
            Text("id: \(model.id)")
            Text("タイトル: \(model.title)")
            Text("詳細: \(model.detail)")
            Text("状態: \(model.isFinish ? "完了" : "未完了")")
        }
    }
}
