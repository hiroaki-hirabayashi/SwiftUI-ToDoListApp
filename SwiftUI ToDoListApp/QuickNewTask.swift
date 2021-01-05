//
//  QuickNewTask.swift
//  SwiftUI ToDoListApp
//
//  Created by 平林 宏淳 on 2021/01/05.
//  Copyright © 2021 平林 宏淳. All rights reserved.
//

import SwiftUI

struct QuickNewTask: View {

    //MARK: - Properties
    let category: ToDoEntity.Category
    @State var newTask = "" // 入力されたタスクを保持
    
    private func addNewTask() {
        newTask = ""
    }
    
    private func cancellTask() {
        newTask = ""
    }
    
    
    var body: some View {
        HStack {
            TextField("新しいToDoを追加", text: $newTask)
            Button(action: {
                self.addNewTask()
            }) {
                Text("追加")
            }
            Button(action: {
                self.cancellTask()
            }) {
                Text("キャンセル")
                    .foregroundColor(.red)
            }

            
        }
    }
}

struct QuickNewTask_Previews: PreviewProvider {
    static var previews: some View {
        QuickNewTask(category: .Priority1st)
    }
}
