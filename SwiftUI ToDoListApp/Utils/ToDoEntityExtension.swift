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
    
    // CoreDateの処理 テストデータ                 //CoreDateのDB操作の為のインスタンス
    static func create(in managedObjectContext: NSManagedObjectContext,
                       category: Category,
                       task: String,
                       time: Date? = Date()){
        let toDo = self.init(context: managedObjectContext)
        print(task)
        toDo.time = time
        toDo.category = category.rawValue
        toDo.task = task
        toDo.state = State.toDo.rawValue
        toDo.id = UUID().uuidString
        
        do {
            try  managedObjectContext.save() // DBに保存
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

    
    enum Category: Int16 {
        case priority1st     // Important & Urgent (第1領域）
        case priority2nd    // Important & Not Urgent (第2領域）
        case priority3rd    // Not Important & Urgent（第3領域）
        case priority4th   // Not Important & Not Urgent（第4領域）
        
        func iconString() -> String { // タイトル文字
            switch self {
                case .priority1st:
                    return "優先度1（重要かつ緊急）"
                case .priority2nd:
                    return "優先度2（重要だが緊急ではない）"
                case .priority3rd:
                    return "優先度3（重要でないが緊急）"
                case .priority4th:
                    return "優先度4（重要でも緊急でもない）"
            }
        }
        func iconImage() -> String { // 画像
            switch self {
                case .priority1st:
                    return "flame"
                case .priority2nd:
                    return "tortoise.fill"
                case .priority3rd:
                    return "alarm"
                case .priority4th:
                    return "tv.music.note"
            }
        }
        func iconColor() -> Color { // 色
            switch self {
                case .priority1st:
                    return .selfRed
                case .priority2nd:
                    return .selfBlue
                case .priority3rd:
                    return .selfGreen
                case .priority4th:
                    return .selfYellow
            }
        }
    }
    
    enum State: Int16 {
        case toDo
        case done
    }

    
    //
    static func toDoNumberCount(in managedObjectContext: NSManagedObjectContext,
                                category: Category) -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoEntity")
        // 検索 categoryに一致するものを取得して
        fetchRequest.predicate = NSPredicate(format: "category == \(category.rawValue)")
        
         //DB管理オブジェクト（managedObjectContext）のcountメソッドで検索条件に当てはまるデータの件数を取得する
        do {
            let count = try managedObjectContext.count(for: fetchRequest)
            return count
        } catch  {
            print("Error: \(error.localizedDescription)")
            return 0
        }
    }
}
