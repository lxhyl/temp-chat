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
    
    @ObservedObject var chatRoom: ChatRoom
    var body: some View {
        VStack {
            ScrollView{
                VStack{
                    ForEach(0..<chatRoom.messages.count, id: \.self){ n in
                        if chatRoom.messages[n].from == chatRoom.currentUserName {
                            Spacer()
                            ChatBubble(isFromCurrentUser: true, msg: chatRoom.messages[n].data)
                                .padding(.horizontal)
                        } else {
                            ChatBubble(isFromCurrentUser: false, msg: chatRoom.messages[n].data)
                                .padding(.horizontal)
                            Spacer()
                        }
                            
                    }
                }
            }
            CustomInputView(sendAction: chatRoom.sendMsg)
                .border(.secondary)
        }
    }
}
/*
struct ChatWindowView_Previews: PreviewProvider {
    static var previews: some View {
        ChatWindowView()
    }
}*/
