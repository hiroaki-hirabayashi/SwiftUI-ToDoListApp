//
//  CategoryView.swift
//  SwiftUI ToDoListApp
//
//  Created by 平林 宏淳 on 2021/01/04.
//  Copyright © 2021 平林 宏淳. All rights reserved.
//

import SwiftUI

//ToDoを優先度でカテゴリー分けする
struct CategoryView: View {
    
    //MARK: - Properties
    var category: ToDoEntity.Category // extensionで作成したToDoEntity内のCategory
    @State var numberOfTasks = 0 //カテゴリー内のタスク数表示
    
    var body: some View {
        VStack {
            VStack (alignment:.leading){ //左揃え
                // extensionで作成したToDoEntity内のCategoryのimage
                Image(systemName: category.toImage())
                    .font(.largeTitle) // アイコンの大きさ
                Text(category.toString())
                Text("・\(numberOfTasks)タスク")
            }
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Image(systemName: "plus")
            }
            Spacer()
        }
        .padding() // 余白
            .frame(maxWidth: .infinity, minHeight: 150) // 横幅最大, 高さの最小固定
            .foregroundColor(.white) // 前景色
            .background(category.toColor()) // 背景色
            .cornerRadius(20) // 角丸に
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CategoryView(category: .Priority1st)
            CategoryView(category: .Priority2nd)
            CategoryView(category: .Priority3rd)
            CategoryView(category: .Priority4th)
            
        }
    }
}
