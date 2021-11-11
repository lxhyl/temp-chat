//
//  ChatBubble.swift
//  test
//
//  Created by candy on 2021/11/11.
//

import SwiftUI

struct ChatBubble: View {
    private var bl: CGFloat = 0.0
    private var br: CGFloat = 0.0
    var isFromCurrentUser = true
    var body: some View {
        Text("hello")
            .padding()
            .frame(height: 30)
            .foregroundColor(Color.white)
            .background(RoundedCornersView(color: .blue, tl: 15, tr: 15, bl: self.bl, br: self.br))
            .foregroundColor(.white)
    }
    init(isFromCurrentUser: Bool) {
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
        ChatBubble(isFromCurrentUser: true)
    }
}
