//
//  KeyboardObserver.swift
//  SwiftUI ToDoListApp
//
//  Created by 平林 宏淳 on 2021/01/08.
//  Copyright © 2021 平林 宏淳. All rights reserved.
//

import SwiftUI
import Combine

// ObservableObjectを継承し変更を監視、変更があればUIに反映する
class KeyboardObserver: ObservableObject {
    
    @Published var keyboardHeight: CGFloat = 0.0
    
    //キーボードの出し入れを監視する
    func startObserve() {
        /*
         keyboardWillChangeFrameNotificationでキーボードの出現を通知する
         キーボードが現れるとkeyboardWillChangeFrameが呼ばれる
         */
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(keyboardWillChangeFrame),
                name: UIResponder.keyboardWillChangeFrameNotification,
                object: nil)
    }
   
    //キーボードの出し入れの監視を止める
    func stopObserve() {
        NotificationCenter
            .default
            .removeObserver(
                self,
                name: UIResponder.keyboardWillChangeFrameNotification,
                object: nil)
    }
    
    //キーボードの高さを計算してkeyboardHeightに反映する
    @objc func keyboardWillChangeFrame(_ notification: Notification) {
        if
            let keyboardEndFrame = notification
                .userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                as? NSValue,
            let keyboardBeginFrame = notification
                .userInfo?[UIResponder.keyboardFrameBeginUserInfoKey]
                as? NSValue
        {
            let endMinY = keyboardEndFrame.cgRectValue.minY
            let beginMinY = keyboardBeginFrame.cgRectValue.minY
            keyboardHeight = beginMinY - endMinY
            if keyboardHeight < 0 {
                keyboardHeight = 0
            }
        }
    }
}
