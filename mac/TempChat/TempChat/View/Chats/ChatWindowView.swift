//
//  ChatWindowView.swift
//  test
//
//  Created by candy on 2021/11/10.
//

import SwiftUI

struct ChatWindowView: View {
    
    @ObservedObject var chatRoom: ChatRoom
    @Namespace var bottomID
    @State var searchText = ""
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView(.vertical) {
                    VStack{
                        ForEach(0..<chatRoom.messages.count, id: \.self){ n in
                            let isCurrentUser =  chatRoom.messages[n].from == chatRoom.currentUserName
                            ChatBubble(isCurrentUser, msg: chatRoom.messages[n].data,name: chatRoom.messages[n].from)
                                .padding(.horizontal)
                                .onAppear{
                                        proxy.scrollTo(bottomID,anchor: UnitPoint(x: 0.5, y: 2))
                                }
                        }
                    }.id(bottomID)
                }
            }
            
            CustomInputView(sendAction: chatRoom.sendMsg)
                .frame(height: 100)
        }
        .navigationTitle(chatRoom.id)
        .navigationSubtitle(chatRoom.webSocketDelegate.isConnected ? "在线" : "离线")
        .searchable(text: $searchText)
    }
}
/*
struct ChatWindowView_Previews: PreviewProvider {
    static var previews: some View {
        ChatWindowView()
    }
}*/
