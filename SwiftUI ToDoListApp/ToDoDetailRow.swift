//
//  ToDoDetailRow.swift
//  SwiftUI ToDoListApp
//
//  Created by 平林 宏淳 on 2021/01/05.
//  Copyright © 2021 平林 宏淳. All rights reserved.
//

import SwiftUI

struct ToDoDetailRow: View {
    /*
     @ObservedObject 変数が持つメンバーに変更があれば画面に反映
     @State 
    */
    @ObservedObject var observedToDo: ToDoEntity
    
    var body: some View {
        HStack {
            //DBからintgerを取得してrawValueでenumに変換
            CategoryImage(ToDoEntity.Category(rawValue: observedToDo.category))
            // ToDoEntityのstate（状態）がintなのでBoolに変換する
            CheckBox(checked: Binding(get: {
                // stateがdoneであればtrue
                self.observedToDo.state == ToDoEntity.State.done.rawValue
            }, set: {
                // CheckBoxからの値（$0）を受け取って0か1に設定する
                self.observedToDo.state = $0 ? ToDoEntity.State.done.rawValue : ToDoEntity.State.toDo.rawValue
            })) {
                // stateの状態が完了であればstrikethrough（取り消し線）を表示し、未完了であればそのまま表示
                if self.observedToDo.state == ToDoEntity.State.done.rawValue {
                    Text(self.observedToDo.task ?? "no title").strikethrough()
                } else {
                    Text(self.observedToDo.task ?? "no title")
                }
            }
            .foregroundColor(self.observedToDo.state == ToDoEntity.State.done.rawValue ? .secondary : .primary) // stateが完了であれば文字色をグレー 未完了なら黒
        }
    }
}



struct TodoDetailRow_Previews: PreviewProvider {
    static var previews: some View {
        // DB操作のためのcontext取得
        let context = (UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer.viewContext
        // contextをToDoEntityのイニシャライザに渡してインスタンス化
        let newToDo = ToDoEntity(context: context)
        newToDo.task = "将来への人間関係づくり"
        newToDo.state = ToDoEntity.State.toDo.rawValue
        newToDo.category = 0
        
        return ToDoDetailRow(observedToDo: newToDo)
    }
}


