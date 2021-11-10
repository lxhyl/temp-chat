//
//  ContentView.swift
//  test
//
//  Created by candy on 2021/11/10.
//

import SwiftUI

struct ColorDetail: View {
    var color: Color

    var body: some View {
        color
            .frame(width: 200, height: 200)
            .navigationTitle(color.description.capitalized)
    }
}

struct ContentView: View {
    let Chats = [ChatEntity(color: .pink, name: "pink"),ChatEntity(color: .blue, name: "blue")]
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: NewSessionView()){
                    Label("新增会话", systemImage: "plus.rectangle.fill.on.rectangle.fill")
                }
                List(Chats){chat in
                    NavigationLink(chat.name, destination: ChatWindowView(person: chat))
                        
                }
            }
            
            NewSessionView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
