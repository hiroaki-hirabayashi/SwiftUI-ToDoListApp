//
//  CategoryImage.swift
//  SwiftUI ToDoListApp
//
//  Created by 平林 宏淳 on 2021/01/04.
//  Copyright © 2021 平林 宏淳. All rights reserved.
//

import SwiftUI

// ToDoDetailRowに表示するためのアイコン画像
struct CategoryImage: View {
    
    var category: ToDoEntity.Category
    
    init(_ category: ToDoEntity.Category?) {
        self.category = category ?? .Priority1st
    }
    
    var body: some View {
//        Image(systemName: "tortoise.fill")
        Image(systemName: category.toImage())
            .resizable() //画像のサイズ変更可能
            .scaledToFit() //縦横比の固定
            .foregroundColor(.white) //画像の色
            .padding(2.0) // アイコンの余白
            .frame(width: 30, height: 30) //画像サイズ
//            .background(Color(.systemBlue)) //背景色
            .background(category.toColor()) //背景色
            .cornerRadius(6.0) //アイコンの角を丸く
        
        
        
        
    }
}

struct CategoryImage_Previews: PreviewProvider {
    static var previews: some View {
        CategoryImage(ToDoEntity.Category.Priority1st)
    }
}
