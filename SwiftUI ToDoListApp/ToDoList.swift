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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ToDoList_Previews: PreviewProvider {
    static var previews: some View {
        ToDoList(category: .Priority1st)
    }
}
