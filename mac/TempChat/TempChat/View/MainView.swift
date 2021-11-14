//
//  MainView.swift
//  TempChat
//
//  Created by candy on 2021/11/12.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: ViewModel = ViewModel()
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: NewSessionView(join: viewModel.vJoinRoom), label: {
                    Label("新增会话", systemImage: "plus.rectangle.fill.on.rectangle.fill")
                })
                List(viewModel.chatRooms) { item in
                    NavigationLink(destination: ChatWindowView(chatRoom: item)) {
                        Label(item.id, systemImage: "person.3.fill")
                    }
                }
                
            }
            NewSessionView(join: viewModel.vJoinRoom)
            
        }
        
    }
}

/*
struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        let websocketHandle = WebSocketHandle()
        MainView(viewModel: websocketHandle)
    }
}*/
