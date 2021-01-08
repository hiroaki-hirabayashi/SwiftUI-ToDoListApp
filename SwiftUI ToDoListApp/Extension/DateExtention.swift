//
//  DateExtention.swift
//  SwiftUI ToDoListApp
//
//  Created by 平林 宏淳 on 2021/01/08.
//  Copyright © 2021 平林 宏淳. All rights reserved.
//

import Foundation

extension Date {
    //「時分秒」を切り落とした今日の日付を作成
    static var todayDate : Date {
        let calendar = Calendar(identifier: .gregorian)
        let time = Date()
        let today = calendar.startOfDay(for: time)
        return today
    }
    //「時分秒」を切り落とした明日の日付を作成
    static var tomorrowDate : Date {
        let calendar = Calendar(identifier: .gregorian)
        let tomorrow = calendar.date(byAdding: DateComponents(day: 1), to: Date.todayDate)!
        return tomorrow
    }
}
