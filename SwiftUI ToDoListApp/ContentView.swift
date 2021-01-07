//
//  ContentView.swift
//  SwiftUI ToDoListApp
//
//  Created by 平林 宏淳 on 2021/01/04.
//  Copyright © 2021 平林 宏淳. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        VStack(spacing: 0) {
            //.edgesIgnoringSafeArea(.all)にするとアイコンとLabelがSafeAreaを超える為、
            Color.gray
                .edgesIgnoringSafeArea(.top)
                .frame(height: 0)

            UserView(image: Image("Catalina"), userName: "User Name")
            
            VStack(spacing: 0) { //viewの間隔
                HStack(spacing: 0) {
                    CategoryView(categoryViewCategory: .Priority1st)
                    Spacer() //中心の余白
                    CategoryView(categoryViewCategory: .Priority2nd)
                }
                HStack(spacing: 0) {
                    CategoryView(categoryViewCategory: .Priority3rd)
                    Spacer() //中心の余白
                    CategoryView(categoryViewCategory: .Priority4th)
                }
            }.padding() // 余白
            
            TodayToDo()
        }.background(Color.gray) // 背景色
            .edgesIgnoringSafeArea(.bottom) // SafeAreaを超える
    }
}

struct ContentView_Previews: PreviewProvider {
    static var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, context)

        
    }
}
