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
                ScrollView() {
                    VStack{
                        ForEach(0..<chatRoom.messages.count, id: \.self){ n in
                            HStack {
                                if chatRoom.messages[n].from == chatRoom.currentUserName {
                                    Spacer()
                                    ChatBubble(isFromCurrentUser: true, msg: chatRoom.messages[n].data)
                                        .padding(.horizontal)
                                        .onAppear(perform: {
                                                proxy.scrollTo(bottomID,anchor: UnitPoint(x: 0.5, y: 1))
                                        })
                                } else {
                                    ChatBubble(isFromCurrentUser: false, msg: chatRoom.messages[n].data)
                                        .padding(.horizontal)
                                        .id(bottomID)
                                        .onAppear(perform: {
                                                proxy.scrollTo(bottomID,anchor: UnitPoint(x: 0.5, y: 1))
                                        })
                                    Spacer()
                                }
                            }
                        }
                    }.id(bottomID)
                    
                }
            }
            
            CustomInputView(sendAction: chatRoom.sendMsg)
                .border(.secondary)
                .frame(height: 100)
        }
        .navigationTitle(chatRoom.id)
        .navigationSubtitle("在线")
        .searchable(text: $searchText)
    }
}
/*
struct ChatWindowView_Previews: PreviewProvider {
    static var previews: some View {
        ChatWindowView()
    }
}*/
