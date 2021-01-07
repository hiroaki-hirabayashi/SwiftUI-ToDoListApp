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
    @State var newTask = ""
    @State var selectDateTime = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("ToDo")) {
                    TextField("ToDo(やる事)追加", text: $newTask)
                }
                
                Section(header: Toggle(isOn: .constant(true), label: { Text("日時") } )) {
                    // selectionには渡すBinding
                    DatePicker(selection: $selectDateTime, label: { Text("日時") })
                }
                
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
