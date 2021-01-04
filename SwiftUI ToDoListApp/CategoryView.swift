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
    var body: some View {
        Image(systemName: category.image()) // extensionで作成したToDoEntity内のCategoryのimage
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: .ImpUrg_1st)
    }
}
