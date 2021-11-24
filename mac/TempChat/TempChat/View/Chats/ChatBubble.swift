//
//  ChatBubble.swift
//  TempChat
//
//  Created by candy on 2021/11/12.
//

import SwiftUI

struct ChatBubble: View {
    private var bl: CGFloat = 0.0
    private var br: CGFloat = 0.0
    var isFromCurrentUser: Bool
    var msg: String
    var name: String
    var body: some View {
        
        HStack(alignment: .bottom) {
            if isFromCurrentUser == true{ Spacer() }
            else{
                NameView(name: name)
            }
            Text(msg)
                .padding(8)
                .foregroundColor(Color.white)
                .background(RoundedCornersView(color: .blue, tl: 15, tr: 15, bl: self.bl, br: self.br))
            .foregroundColor(.white)
            if isFromCurrentUser == true{
                NameView(name: name)
            } else{ Spacer() }
        }
    }
                     init(_ isFromCurrentUser: Bool, msg: String, name: String) {
        self.msg = msg
        self.isFromCurrentUser = isFromCurrentUser
                    self.name = name
        if isFromCurrentUser {
            bl = 15
            br = 0
        } else {
            bl = 0
            br = 15
        }
    }
}

struct ChatBubble_Previews: PreviewProvider {
    static var previews: some View {
        ChatBubble(false, msg: "hello",name: "芜湖男童")
    }
}

struct NameView: View {
    var name: String
    var body: some View {
        Text(name)
            .frame(width: 60)
            .padding(3)
            .background(.black)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 6)
    }
}
