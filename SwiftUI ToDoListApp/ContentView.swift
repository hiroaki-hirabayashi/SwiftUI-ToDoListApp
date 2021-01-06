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

            Color.selfBackground
                .edgesIgnoringSafeArea(.top)
                .frame(height: 0)

            UserView(image: Image("Catalina"), userName: "平林 宏淳")
            
            VStack(spacing: 0) { //viewの間隔
                HStack(spacing: 0) {
                    CategoryView(category: .Priority1st)
                    Spacer() //中心の余白
                    CategoryView(category: .Priority2nd)
                }
                HStack(spacing: 0) {
                    CategoryView(category: .Priority3rd)
                    Spacer() //中心の余白
                    CategoryView(category: .Priority4th)
                }
            }.padding() // 余白
        }.background(Color.selfBackground) // 背景色
            .edgesIgnoringSafeArea(.bottom) // SafeAreaを超える
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
