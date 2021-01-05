//
//  ToDoList.swift
//  SwiftUI ToDoListApp
//
//  Created by 平林 宏淳 on 2021/01/05.
//  Copyright © 2021 平林 宏淳. All rights reserved.
//

import SwiftUI
import CoreData

// ToDo一覧表示
struct ToDoList: View {
    
    //MARK: - Properties
    @FetchRequest( // DBテーブルからデータを取得するアノテーション
        // 取得したデータの並べ替えの条件 この場合はToDoEntityを実施する時間順
        sortDescriptors: [NSSortDescriptor(keyPath: \ToDoEntity.time,
                                           ascending: true)],
        animation: .default)
    
    var toDoList: FetchedResults<ToDoEntity> // テーブルの全データが入る
    var category: ToDoEntity.Category

    var body: some View {
        List {
            ForEach(toDoList) { toDo in
                Text(toDo.task ?? "no title")
            }
        }
    }
}

struct ToDoList_Previews: PreviewProvider {
    /*
     DBのデータをリスト表示
     CoreDateを操作するためのContextを設定
     AppDelegateのインスタンス取得
     Contextの指定にはenviroment Modifierで設定する
     設定先はmanagedObjectContextと設定したcontext
     */
    static let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    
    static var previews: some View {
        ToDoList(category: .Priority1st)
            .environment(\.managedObjectContext, context)
    }
}
