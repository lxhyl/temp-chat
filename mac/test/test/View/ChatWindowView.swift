//
//  ChatWindowView.swift
//  test
//
//  Created by candy on 2021/11/10.
//

import SwiftUI

struct ChatWindowView: View {
    var person: ChatEntity
    var body: some View {
        Text("与\(person.name)的聊天窗口")
    }
}

struct ChatWindowView_Previews: PreviewProvider {
    static var previews: some View {
        ChatWindowView(person: ChatEntity(color: .blue, name: "null"))
    }
}
