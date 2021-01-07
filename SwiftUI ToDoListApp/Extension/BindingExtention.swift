//
//  BindingExtention.swift
//  SwiftUI ToDoListApp
//
//  Created by 平林 宏淳 on 2021/01/07.
//  Copyright © 2021 平林 宏淳. All rights reserved.
//

import SwiftUI

extension Binding {
    
    /*
     DateのToggleのON OFFで入力未入力を切り替えたい
     オプショナルのDate型をBoolに変換
     任意のBindingを取得しnilかそうでないかによってtrue,falseを返す
     **/
    init<T>(isNotNil source: Binding<T?>, defaultValue: T) where Value == Bool {
        // オプショナルのDate型が入る nilでないならtrue nilならfalse
        self.init(get: { source.wrappedValue != nil },
                  set: { source.wrappedValue = $0 ? defaultValue : nil })
        // setにToggle結果が入る trueならdefaultValue、falseならnilがwrappedValueに格納される
    }
    
    // DatePickerに渡す$selectDateTimeがoptional型
    init(_ source: Binding<Value?>, _ defaultValue: Value) {
        
        self.init(get:{
            /*
             wrappedValueはoptional型なのでnilになる時がある
             wrappedValueがnilならdefaultValueを格納してnilじゃない状態にする
             */
            if source.wrappedValue == nil {
                source.wrappedValue = defaultValue
            }
            return source.wrappedValue ?? defaultValue
            
        },set:{
            source.wrappedValue = $0
        })
    }
    
}
