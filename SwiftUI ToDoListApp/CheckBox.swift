//
//  CheckBox.swift
//  SwiftUI ToDoListApp
//
//  Created by 平林 宏淳 on 2021/01/04.
//  Copyright © 2021 平林 宏淳. All rights reserved.
//

import SwiftUI
                //型パラメータ  //型パラメータの条件
struct CheckBox<Label>: View where Label: View {
    
    //MARK: - Properties
    @Binding var checked: Bool //Binding 他のViewと連携、共有出来るようにする
    private var label: () -> Label //クロージャー型
    
    public init(checked: Binding<Bool>,
                @ViewBuilder label: @escaping () -> Label) { //@ViewBuilder Viewを開業して並べて列挙して複数のViewを渡す構文が使える
        self._checked = checked
        self.label = label
    }
    
    
    var body: some View {
        HStack {
            Image(systemName: checked ? "checkmark.circle.fill" : "circle") //trueならcheckmark.circle.fill falseならcircle
                .onTapGesture {
                    self.checked.toggle()
            }
            label()
        }
    }
}

struct CheckBox_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CheckBox(checked: .constant(false)) {
                Text("牛乳")
            } //Bindingを受け取る時は.constant()を使う
//            CheckBox(checked: .constant(true))
        }
    }
}

