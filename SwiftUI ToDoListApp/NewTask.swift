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
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("ToDo(やる事)追加", text: $newTask)
            }.navigationBarTitle("ToDo追加")
        }
    }
}

struct NewTask_Previews: PreviewProvider {
    static var previews: some View {
        NewTask()
    }
}
