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
                Button("添加聊天", action: {
                    if let n = viewModel.isChatActive.firstIndex(of: true){
                        viewModel.isChatActive[n] = false
                    }
                }).padding(.top)
                List(0..<viewModel.chatRooms.count, id: \.self) { n in
                    NavigationLink(destination: ChatWindowView(chatRoom: viewModel.chatRooms[n]), isActive: $viewModel.isChatActive[n]) {
                        Label(viewModel.chatRooms[n].id, systemImage: "person.3.fill")
                    }
                    .deleteDisabled(true)
                    .onDeleteCommand(perform: {
                        print("delete")
                    })
                }
                
            }
            if !viewModel.isChatActive.contains(true) {
                NewSessionView(join: viewModel.vJoinRoom)
            }
            
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
