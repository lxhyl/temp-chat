//
//  MessageView.swift
//  test
//
//  Created by candy on 2021/11/11.
//

import SwiftUI

struct MessageView: View {
    @State var isFromCurrentUser = true
    var body: some View {
        ScrollView{
            VStack{
                ForEach((0...10), id: \.self) { _ in
                    if isFromCurrentUser{
                        HStack{
                            Spacer()
                            ChatBubble(isFromCurrentUser: true)
                                .foregroundColor(.white)
                                .padding(.trailing, 30)
                            
                        }
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

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
