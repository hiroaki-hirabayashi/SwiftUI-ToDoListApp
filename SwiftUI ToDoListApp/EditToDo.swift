//
//  NewTask.swift
//  SwiftUI ToDoListApp
//
//  Created by 平林 宏淳 on 2021/01/07.
//  Copyright © 2021 平林 宏淳. All rights reserved.
//

import SwiftUI

// ToDo編集画面
struct EditToDo: View {
    
    //MARK: - Properties
    @ObservedObject var editToDo: ToDoEntity // DBの監視 SwiftUI上でこの値を変更したらDBに反映される
    @State var showingActionSheet = false // actionsheetの表示を制御する
    
    var categoryArray: [ToDoEntity.Category]
        = [.Priority1st, .Priority2nd, .Priority3rd, .Priority4th]
    
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode // viewの表示制御オブジェクトを取得
    
    //MARK: - function
    
    //データ保存のfunction 永続化
    private func save() {
        do {
            try self.viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("エラー\(error), \(error.userInfo)")
        }
    }
    
    // viewContext DB操作オブジェクトに対してdeleteメソッド
    private func delete() {
        viewContext.delete(editToDo)
        save()
    }
    
    
    
    
    var body: some View {
        NavigationView {
            Form {
                // ToDo入力セクション
                Section(header: Text("ToDo")) {
                    TextField("ToDo(やる事)追加", text: Binding($editToDo.task, "New ToDo"))
                }
                
                /*
                 日時入力セクション
                 Binding(isNotNil: $selectDateTime, defaultValue: Date())
                 selectDateTimeの値がnilかそうでないかをToggleと連動させる（ToggleがONで!=nil OFFでnilが$selectDateTimeに入る）
                 */
                Section(header: Toggle(isOn: Binding(isNotNil: $editToDo.time, defaultValue: Date()), label: { Text("日時") } )) {
                    if editToDo.time != nil { // selectDateTimeがnilでなかったら時間設定表示 nilなら表示しない
                        /*
                         selectionには渡すBindingを設定
                         $selectDateTimeだとoptionalのBindingを渡してしまうのでエラーになる（Date型のBindingを渡さなければならない）
                         Binding($selectDateTime, Date())としてoptionalをBindingする
                         */
                        DatePicker(selection: Binding($editToDo.time, Date()), label: { Text("日時") })
                    } else {
                        Text("未設定").foregroundColor(.secondary)
                    }
                    
                }
                
                // カテゴリーピッカー $categoryにtagの値が入る
                Picker(selection: $editToDo.category, label: Text("カテゴリー")) {
                    ForEach(categoryArray, id: \.self) { category in
                        HStack {
                            CategoryImage(category)
                            Text(category.iconString())
                        }.tag(category.rawValue)
                    }
                }
                
                //削除セクション
                Section(header: Text("ToDo削除")) {
                    Button(action: {
                        self.showingActionSheet = true
                    }) {
                        HStack(alignment: .center) {
                            Image(systemName: "minus.circle.fill")
                            Text("削除")
                        }.foregroundColor(.red)
                    }
                }
            }.navigationBarTitle("ToDoの編集")
                .navigationBarItems(trailing: Button(action: {
                    self.save()
                    self.presentationMode.wrappedValue.dismiss()
                    
                }) {
                    Text("閉じる")
                })
                .actionSheet(isPresented: $showingActionSheet) { //showingActionSheetがtrueの時表示
                    ActionSheet(title: Text("ToDoの削除"), message: Text("この項目を削除します。よろしいですか？"), buttons: [
                        .destructive(Text("削除する")) { // .destructive ボタンのデザイン
                        self.delete()
                        self.presentationMode.wrappedValue.dismiss()
                        },.cancel(Text("キャンセル")) // cancel ボタンのデザイン

                    ])
            }
            
    }
}

struct EditToDo_Previews: PreviewProvider {
    static var context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext // DB操作対応
    static var previews: some View {
        let edit = ToDoEntity(context: context)
        return EditToDo(editToDo: edit)
            .environment(\.managedObjectContext, context)
            .environment(\.locale, Locale(identifier: "ja_JP"))
        
    }
}
}
