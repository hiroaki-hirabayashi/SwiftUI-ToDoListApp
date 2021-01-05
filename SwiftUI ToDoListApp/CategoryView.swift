//
//  CategoryView.swift
//  SwiftUI ToDoListApp
//
//  Created by 平林 宏淳 on 2021/01/04.
//  Copyright © 2021 平林 宏淳. All rights reserved.
//

import SwiftUI

struct CategoryView: View {
    
    //MARK: - Properties
    var category: ToDoEntity.Category // extensionで作成したToDoEntity内のCategory
    @State var numberOfTasks = 0 //カテゴリー内のタスク数表示
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: category.toImage()) // extensionで作成したToDoEntity内のCategoryのimage
                Text(category.toString())
                Text("・\(numberOfTasks)タスク")
            }
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Image(systemName: "plus")
            }
            Spacer()
        }
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
