//
//  NewSessionView.swift
//  TempChat
//
//  Created by candy on 2021/11/12.
//

import SwiftUI

struct NewSessionView: View {
    @State private var roomId: String = ""
    @State private var name: String = ""
    var join: (String, String) -> Void
    
    var body: some View {
        VStack {
            Form {
                TextField("房间名:", text: $roomId)
                TextField("聊天昵称:", text: $name)
            }.frame(maxWidth: 300)
            Button(action: {join(roomId,name)}, label: {
                Text("加入")
            })
        }
        .navigationTitle("加入房间")
    }
}
/*
struct NewSessionView_Previews: PreviewProvider {
    static var previews: some View {
        NewSessionView()
    }
}*/
