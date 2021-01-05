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
    var toDoCategory: ToDoEntity.Category

    var body: some View {
        VStack {
            List {
                ForEach(toDoList) { toDo in
                    Text(toDo.task ?? "no title")
                }
            }
            QuickNewTask(category: toDoCategory)
                .padding()
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
    static let container = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer
    static let context = container.viewContext
    
    static var previews: some View {
//        ToDoList(category: .Priority1st)
//            .environment(\.managedObjectContext, context)
        
        // テストデータの全削除
        let request = NSBatchDeleteRequest(
            fetchRequest: NSFetchRequest(entityName: "ToDoEntity"))
        try! container.persistentStoreCoordinator.execute(request,
                                                          with: context)
        
        // データを追加 ToDoEntityに追加したcreateメソッド
        ToDoEntity.create(in: context,
                          category: .Priority1st, task: "炎上プロジェクト")
        ToDoEntity.create(in: context,
                          category: .Priority2nd, task: "自己啓発")
        ToDoEntity.create(in: context,
                          category: .Priority3rd, task: "意味のない会議")
        ToDoEntity.create(in: context,
                          category: .Priority4th, task: "暇つぶし")
        
        // 複数行ある場合はreturnを定義しなければならない？
        return ToDoList(toDoCategory: .Priority1st)
            .environment(\.managedObjectContext, context)
        
    }


}
