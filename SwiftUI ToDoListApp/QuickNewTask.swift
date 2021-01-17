//
//  QuickNewTask.swift
//  SwiftUI ToDoListApp
//
//  Created by 平林 宏淳 on 2021/01/05.
//  Copyright © 2021 平林 宏淳. All rights reserved.
//

import SwiftUI

// ToDo入力
struct QuickNewTask: View {

    //MARK: - Properties
    let category: ToDoEntity.Category

    var isEnabled = false

    @State var newTask = "" // 入力されたタスクを保持
    @Environment(\.managedObjectContext) var ViewContext // DB操作のためのContext
    
    private func addNewTask() {
        ToDoEntity.create(in: self.ViewContext, category: self.category, task: self.newTask)
        newTask = ""
    }
    
    private func cancellTask() {
        newTask = ""
    }
    
    
    var body: some View {
        HStack {
            TextField("新しいToDoを追加", text: $newTask) {
                self.addNewTask() //onCommit Enterを押した時にもaddNewTaskが呼ばれる
            }.textFieldStyle(RoundedBorderTextFieldStyle())
            
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
    static var context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    
    static var previews: some View {
        QuickNewTask(category: .priority1st)
            .environment(\.managedObjectContext, context) // DB操作オブジェクト
    }
}
