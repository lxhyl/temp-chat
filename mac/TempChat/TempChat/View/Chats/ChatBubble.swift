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
    var isFromCurrentUser = true
    @State var msg: String
    var body: some View {
        Text(msg)
            .padding()
            .frame(height: 30)
            .foregroundColor(Color.white)
            .background(RoundedCornersView(color: .blue, tl: 15, tr: 15, bl: self.bl, br: self.br))
            .foregroundColor(.white)
    }
    init(isFromCurrentUser: Bool, msg: String) {
        self.msg = msg
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
        ChatBubble(isFromCurrentUser: true, msg: "hello")
    }
}
