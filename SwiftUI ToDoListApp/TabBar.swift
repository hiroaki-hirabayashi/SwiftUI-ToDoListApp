//
//  TabBar.swift
//  SwiftUI ToDoListApp
//
//  Created by 平林 宏淳 on 2021/01/12.
//  Copyright © 2021 平林 宏淳. All rights reserved.
//

import SwiftUI

struct TabBar: View {

    
//    init() {
//        UITabBar.appearance().barTintColor = .systemBackground
//    }

    var tabBarCategory: ToDoEntity.Category // extensionで作成したToDoEntity内のCategory

    
    @State var selectedIndex = 0
    @State var shouldShowModal = false
    @Environment(\.managedObjectContext) var viewContext

    
    let tabBarImageNames = ["person", "gear", "plus.app.fill", "pencil", "lasso"]
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                
                Spacer()
//                    .sheet(isPresented: $shouldShowModal, content:  {
//                        Button(action: {self.shouldShowModal.toggle()}, label: {
//                            Text("FullScreen")
//                        })
//                    })
                
                    .sheet(isPresented: $shouldShowModal) {
                        /* isPresentedがtrueの時、シート表示 $showListはonTapGestureで制御
                         sheetModifire でシートの中身（content）を指定する
                         */
                        ToDoList(toDoCategory: self.tabBarCategory)
                        .environment(\.managedObjectContext, self.viewContext) // これを記入しないとDBが動作しない。ToDoList_Previewsに詳細有り
                }

                
                
                if selectedIndex == 0 {
                    NavigationView {
                        Text("First")
                            .navigationBarTitle("First Tab")
                    }
                } else if selectedIndex == 1 {
                    Text("test")
                } else {
                    Text("TT")
                }
                
                
            }
            
            Spacer()
            
            HStack {
                ForEach (0..<5) { num in
                    Button(action: {
                        
                        if num == 2 {
                            self.shouldShowModal.toggle()
                            return
                        }
                        
                        self.selectedIndex = num
                    }, label: {
                        Spacer()
                        
                        if num == 2 {
                            Image(systemName: self.tabBarImageNames[num])
                                .font(.system(size: 44, weight: .bold)) // 画像の大きさ
                                .foregroundColor(.red)

                        } else {
                            
                            Image(systemName: self.tabBarImageNames[num])
                                .font(.system(size: 24, weight: .bold)) // 画像の大きさ
                                .foregroundColor(self.selectedIndex == num ? Color(.black) : .secondary)
                        } // 画像の色 .init(white: 0.8)
                        Spacer()
                    })
                    
                    
                }
            }
        }
    }
}

//TabView {
//    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//        .tabItem {
//            Image(systemName: "person")
//            Text("TabBar")
//    }
//
//    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//        .tabItem {
//            Image(systemName: "gear")
//            Text("TabBar")
//    }
//
//}



struct TabBar_Previews: PreviewProvider {
    static let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext

    static var previews: some View {
        TabBar(tabBarCategory: .priority1st)
            .environment(\.managedObjectContext, context)
    }
}
