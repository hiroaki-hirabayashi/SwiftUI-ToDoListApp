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
    var categoryViewCategory: ToDoEntity.Category // extensionで作成したToDoEntity内のCategory
    @State var numberOfTasks = 0 //カテゴリー内のタスク数表示
    @State var showList = false
    @Environment(\.managedObjectContext) var viewContext
    @State var addNewTaskView = false
    
    var body: some View {
        VStack {
            VStack (alignment:.leading){ //左揃え
                // extensionで作成したToDoEntity内のCategoryのimage
                Image(systemName: categoryViewCategory.iconImage())
                    .font(.largeTitle) // アイコンの大きさ
                    .sheet(isPresented: $showList) {
                        /* isPresentedがtrueの時、シート表示 $showListはonTapGestureで制御
                         sheetModifire でシートの中身（content）を指定する
                         */
                        ToDoList(toDoCategory: self.categoryViewCategory)
                            .environment(\.managedObjectContext, self.viewContext) // これを記入しないとDBが動作しない。ToDoList_Previewsに詳細有り
                }
                Text(categoryViewCategory.iconString())
                Text("・\(numberOfTasks)タスク")
            }
            Button(action: {
                self.addNewTaskView = true // ボタンタップでtrueに
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.black)
            }.sheet(isPresented: $addNewTaskView) { // trueでNewTaskをポップアップ
                NewTask(newTsskCategory: self.categoryViewCategory.rawValue)
                    .environment(\.managedObjectContext, self.viewContext)
                    .environment( \.locale, Locale(identifier: "ja_JP")) // Pickerを日本語化
            }
            
            Spacer()
        }
            .padding() // 余白
            .frame(maxWidth: .infinity, minHeight: 150) // 横幅最大, 高さの最小固定
            .foregroundColor(.white) // 前景色
            .background(categoryViewCategory.iconColor()) // 背景色
            .cornerRadius(20) // 角丸に
            .onTapGesture {
                self.showList = true
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    
    static var previews: some View {
        VStack {
            CategoryView(categoryViewCategory: .Priority1st)
            CategoryView(categoryViewCategory: .Priority2nd)
            CategoryView(categoryViewCategory: .Priority3rd)
            CategoryView(categoryViewCategory: .Priority4th)
        }.environment(\.managedObjectContext, context)
    }
}
