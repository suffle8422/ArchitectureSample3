//
//  TodoListScene.swift
//  LocalModules
//
//  Created by Ibuki Onishi on 2025/05/16.
//

import SwiftUI
import Core
import CoreUI

package struct TodoListScene: View {
    @State var state: TodoListSceneState

    package init(state: TodoListSceneState) {
        self.state = state
    }
    
    package var body: some View {
        NavigationStack {
            todoListView()
                .navigationTitle("TODOリスト")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(
                            action: {
                                Task { await state.insertTodo() }
                            },
                            label: { Image(systemName: "plus")}
                        )
                    }
                }
                .onAppear {
                    Task { await state.fetchTodos() }
                }
        }
    }
}

private extension TodoListScene {
    func todoListView() -> some View {
        List(state.todos, id: \.self) { todo in
            NavigationLink(destination: {
                LazyView(state.viewResolver.show(AppScene.todoDetailScene(entity: todo)))
            }, label: {
                Text(todo.title)
                    .strikethrough(todo.isFinish)
            })
        }
    }
}
