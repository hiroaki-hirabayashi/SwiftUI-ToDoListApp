//
//  TodayToDo.swift
//  SwiftUI ToDoListApp
//
//  Created by 平林 宏淳 on 2021/01/08.
//  Copyright © 2021 平林 宏淳. All rights reserved.
//

import SwiftUI

// メイン画面に表示させる一覧リスト
struct TodayToDo: View {
    @FetchRequest(  // DBテーブルからデータを取得するアノテーション
        // 取得したデータの並べ替えの条件 この場合はToDoEntityの日時
        sortDescriptors: [NSSortDescriptor(keyPath: \ToDoEntity.time,
                                           ascending: true)],
        // 今日の0時から明日の0時までの1日分のデータ
        predicate: NSPredicate(format:"time BETWEEN {%@ , %@}", Date.todayDate as NSDate, Date.tomorrowDate as NSDate),
        animation: .default)
    
    var todayToDo: FetchedResults<ToDoEntity>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("本日のToDo")
                .font(.footnote).bold().padding()
            List(todayToDo) { toDo in
                ToDoDetailRow(observedToDo: toDo)
            }
        }.background(Color(UIColor.systemBackground))
        .clipShape(CornerRadius(topRight: 40, topLelt: 40, bottomRight: 0, bottomLeft: 0)) // viewをclipShapeで切り抜く
        
    }
}

struct TodayToDo_Previews: PreviewProvider {
    static var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    static var previews: some View {
        TodayToDo()
            .environment(\.managedObjectContext, context)
    }
}
