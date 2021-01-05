//
//  ToDoEntityExtension.swift
//  SwiftUI ToDoListApp
//
//  Created by 平林 宏淳 on 2021/01/04.
//  Copyright © 2021 平林 宏淳. All rights reserved.
//

import CoreData
import SwiftUI

extension ToDoEntity {
    enum Category: Int16 {
        case Priority1st     // Important & Urgent (第1領域）
        case Priority2nd    // Important & Not Urgent (第2領域）
        case Priority3rd    // Not Important & Urgent（第3領域）
        case Priority4th   // Not Important & Not Urgent（第4領域）
        
        func toString() -> String { // タイトル文字
            switch self {
                case .Priority1st:
                    return "重要かつ緊急"
                case .Priority2nd:
                    return "重要だが緊急ではない"
                case .Priority3rd:
                    return "重要でないが緊急"
                case .Priority4th:
                    return "重要でも緊急でもない"
            }
        }
        func toImage() -> String { // 画像
            switch self {
                case .Priority1st:
                    return "flame"
                case .Priority2nd:
                    return "tortoise.fill"
                case .Priority3rd:
                    return "alarm"
                case .Priority4th:
                    return "tv.music.note"
            }
        }
        func toColor() -> Color { // 色
            switch self {
                case .Priority1st:
                    return .selfRed
                case .Priority2nd:
                    return .selfBlue
                case .Priority3rd:
                    return .selfGreen
                case .Priority4th:
                    return .selfYellow
            }
        }
    }
    
    enum State: Int16 {
        case todo
        case done
    }
}
