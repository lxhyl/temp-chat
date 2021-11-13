//
//  MainView.swift
//  TempChat
//
//  Created by candy on 2021/11/12.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: WebSocketHandle
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: NewSessionView(join: viewModel.joinChat), label: {
                    Label("新增会话", systemImage: "plus.rectangle.fill.on.rectangle.fill")
                })
                List(viewModel.chatTable, id: \.self) { item in
                    NavigationLink(destination: ChatWindowView()) {
                        Label(item, systemImage: "person.3.fill")
                    }
                }
                
            }
            NewSessionView(join: viewModel.joinChat)
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
