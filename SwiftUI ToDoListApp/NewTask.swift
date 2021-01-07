//
//  NewTask.swift
//  SwiftUI ToDoListApp
//
//  Created by 平林 宏淳 on 2021/01/07.
//  Copyright © 2021 平林 宏淳. All rights reserved.
//

import SwiftUI

struct NewTask: View {

    //MARK: - Properties
    @State var newTask = "" // ToDo内容を保持
    @State var selectDateTime: Date? = Date()  //日時 nilを持ちたい（optional型）にしたいのでDate?としてます
    @State var category = ToDoEntity.Category.Priority1st.rawValue // カテゴリーピッカーの内容を保持
    var categoryArray: [ToDoEntity.Category]
        = [.Priority1st, .Priority2nd, .Priority3rd, .Priority4th]
    
    var body: some View {
        NavigationView {
            Form {
                // ToDo入力セクション
                Section(header: Text("ToDo")) {
                    TextField("ToDo(やる事)追加", text: $newTask)
                }
                
                /*
                 日時入力セクション
                 Binding(isNotNil: $selectDateTime, defaultValue: Date())
                 selectDateTimeの値がnilかそうでないかをToggleと連動させる（ToggleがONで!=nil OFFでnilが$selectDateTimeに入る）
                 */
                Section(header: Toggle(isOn: Binding(isNotNil: $selectDateTime, defaultValue: Date()), label: { Text("日時") } )) {
                    if selectDateTime != nil { // selectDateTimeがnilでなかったら時間設定表示 nilなら表示しない
                        /*
                         selectionには渡すBindingを設定
                         $selectDateTimeだとoptionalのBindingを渡してしまうのでエラーになる（Date型のBindingを渡さなければならない）
                         Binding($selectDateTime, Date())としてoptionalをBindingする
                         */
                        DatePicker(selection: Binding($selectDateTime, Date()), label: { Text("日時") })
                    } else {
                        Text("未設定").foregroundColor(.secondary)
                    }
                    
                }
                
                // カテゴリーピッカー $categoryにtagの値が入る
                Picker(selection: $category, label: Text("カテゴリー")) {
                    ForEach(categoryArray, id: \.self) { category in
                        HStack {
                            CategoryImage(category)
                            Text(category.iconString())
                        }.tag(category.rawValue)
                    }
                }
                
                //キャンセルセクション
                Section(header: Text("取り消し")) {
                    Button(action: {}) {
                        HStack(alignment: .center) {
                            Image(systemName: "minus.circle.fill")
                            Text("キャンセル")
                        }.foregroundColor(.red)
                    }
                }
            }.navigationBarTitle("ToDo追加")
        }
    }
}

struct NewTask_Previews: PreviewProvider {
    static var previews: some View {
        NewTask()
            .environment(\.locale, Locale(identifier: "ja_JP")) // NewTask_Previews上で日本語化

    }
}
