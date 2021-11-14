//
//  MessageView.swift
//  test
//
//  Created by candy on 2021/11/11.
//

import SwiftUI

struct MessageView: View {
    @State var chatContents: [MsgEntity]
    var body: some View {
        ScrollView{
            VStack{
                ForEach(0..<chatContents.count, id: \.self){ n in
                    Text("msg:\(chatContents[n].data)")
                }
            }
        }
    }
}
/*
struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}*/
