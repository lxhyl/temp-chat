//
//  NewSessionView.swift
//  TempChat
//
//  Created by candy on 2021/11/12.
//

import SwiftUI

struct NewSessionView: View {
    @State private var roomId: String = "lxhyl"
    @State private var name: String = ""
    var join: (String, String) -> Void
    var body: some View {
        VStack {
            Form {
                TextField("房间名:", text: $roomId, prompt: Text("require"))
                TextField("聊天昵称:", text: $name, prompt: Text("require"))
                
            }
            .onSubmit{
                print(roomId)
                print(name)
            }
            
            Button(action: {
                join(roomId,name)
            }, label: {
                Text("加入")
            })
        }
        .padding()
    }
}
/*
struct NewSessionView_Previews: PreviewProvider {
    static var previews: some View {
        NewSessionView()
    }
}*/
