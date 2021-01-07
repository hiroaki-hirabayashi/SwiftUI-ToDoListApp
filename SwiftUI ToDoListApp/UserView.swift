//
//  UserView.swift
//  SwiftUI ToDoListApp
//
//  Created by 平林 宏淳 on 2021/01/04.
//  Copyright © 2021 平林 宏淳. All rights reserved.
//

import SwiftUI

// ユーザー画面
struct UserView: View {
    
    //MARK: - Properties
    let image: Image
    let userName: String
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) { //左寄せ
                Text("こんにちわ")
                    .foregroundColor(Color.selfTitle) //文字色に自作した色指定
                    .font(.footnote)
                Text("\(userName)")
                    .foregroundColor(Color.selfTitle) //文字色に自作した色指定
                    .font(.title)
            }
            Spacer()
            image
                .resizable() //サイズ変更可能に
                .frame(width: 60, height: 60)
                .clipShape(Circle())
        }
        .padding() //HStackに余白を入れる
            .background(Color.gray) //背景色に自作した色指定
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UserView(image: Image("Catalina"), userName: "User Name")
            Circle()
        }
    }
}
