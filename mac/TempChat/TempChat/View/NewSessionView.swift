//
//  NewSessionView.swift
//  TempChat
//
//  Created by candy on 2021/11/12.
//

import SwiftUI

struct NewSessionView: View {
    @State private var roomId: String = "lxhyl"
    var join: (String) -> Void
    var body: some View {
        HStack {
            TextField("房间名", text: $roomId).onSubmit {
                join(roomId)
            }
            Button(action: {
                join(roomId)
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
