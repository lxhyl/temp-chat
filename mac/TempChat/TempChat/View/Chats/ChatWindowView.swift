//
//  ChatWindowView.swift
//  test
//
//  Created by candy on 2021/11/10.
//

import SwiftUI

struct ChatWindowView: View {
    /*let msg1 = MsgEntity(roomid: "lxhyl", type: "text", data: "hello", from: "Bob", date: 1245545)
    let msg2 = MsgEntity(roomid: "lxhyl", type: "text", data: "hello", from: "Bob", date: 1245545)
    let msg3 = MsgEntity(roomid: "lxhyl", type: "text", data: "hello", from: "Bob", date: 1245545)
    let msg4 = MsgEntity(roomid: "lxhyl", type: "text", data: "hello", from: "Bob", date: 1245545)
    @State var chatContents = [msg1,msg2]*/
    var body: some View {
        VStack {
            MessageView()
            CustomInputView()
                .border(.secondary)
        }
    }
}

struct ChatWindowView_Previews: PreviewProvider {
    static var previews: some View {
        ChatWindowView()
    }
}
