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
    
    var toDoListEntity: FetchedResults<ToDoEntity> // DBテーブルの全データが入る
    var toDoCategory: ToDoEntity.Category
    @Environment(\.managedObjectContext) var viewContext // DB操作オブジェクト
   
    // @Published var keyboardHeightに変更があれば反映する
    @ObservedObject var keyboardObserver = KeyboardObserver()

    // IndexSet どのデータを削除するかが入る forで回して対象のentityを取得して削除を繰り返す
    private func swipeDeleteToDo(at offsets: IndexSet) {
        for index in offsets {
            let entity = toDoListEntity[index]
            viewContext.delete(entity)
        }
        do {
            try viewContext.save() // 削除した事をセーブする
        } catch {
            print("削除エラー\(offsets)")
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(toDoListEntity) { toDoList in
                        // ToDoEntityのcategory
                        if toDoList.category == self.toDoCategory.rawValue {
                            // 画面遷移で開きたいviewを指定
                            NavigationLink(destination: EditToDo(editToDo: toDoList)) {
                                // ToDoDetileRowが表示されセルをタップするとEditToDoの遷移する
                                ToDoDetailRow(observedToDo: toDoList, hideIcon: true)
                            }
                        }
                    }.onDelete(perform: swipeDeleteToDo(at:))
                }
                QuickNewTask(category: toDoCategory)
                    .padding()
            }.navigationBarTitle(toDoCategory.iconString())

            .navigationBarItems(trailing: EditButton()) // 編集ボタン追加
        }.onAppear() { // viewが表示される時
            self.keyboardObserver.startObserve()
            UIApplication.shared.closeKeyboard() //キーボードをしまう
        }.onDisappear() { // viewが閉じる時
            self.keyboardObserver.stopObserve()
            UIApplication.shared.closeKeyboard()
        }.padding(.bottom, keyboardObserver.keyboardHeight)
        // キーボード高さに合わせてpaddingを取る（全体が上に上がる）
    }
}

struct ToDoList_Previews: PreviewProvider {
    /*
     DBのデータをリスト表示
     CoreDateを操作するためのContextを設定する。しないとDBが動作しない
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
                          category: .priority1st, task: "優先度1")
        ToDoEntity.create(in: context,
                          category: .priority2nd, task: "優先度2")
        ToDoEntity.create(in: context,
                          category: .priority3rd, task: "優先度3")
        ToDoEntity.create(in: context,
                          category: .priority4th, task: "優先度4")
        
        // 複数行ある場合はreturnを定義しなければならない？
        return ToDoList(toDoCategory: .priority1st)
            .environment(\.managedObjectContext, context)
            

        
    }


}
