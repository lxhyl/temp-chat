//
//  MessageView.swift
//  test
//
//  Created by candy on 2021/11/11.
//

import SwiftUI

struct MessageView: View {
    @State var currentUser = "me"
    @State var chatContents: [MsgEntity] = []
    var body: some View {
        ScrollView{
            VStack{
                if chatContents.count > 0 {
                    ForEach(0..<chatContents.count){ i in
                        if chatContents[i].from == currentUser {
                            HStack{
                                Spacer()
                                ChatBubble(isFromCurrentUser: true)
                                    .foregroundColor(.white)
                                    .padding(.trailing, 30)
                                
                            }
                        } else {
                            HStack{
                                ChatBubble(isFromCurrentUser: false)
                                    .foregroundColor(.white)
                                    .padding(.leading,30)
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
