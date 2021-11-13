//
//  CustomInputView.swift
//  test
//
//  Created by candy on 2021/11/11.
//

import SwiftUI

struct CustomInputView: View {
    @State var text: String = ""
    var sendAction: () -> Void = sendMsg
    var action: () -> Void = sendMsg
    var body: some View {
        HStack{
            TextEditor(text: $text)
                .onSubmit {
                    sendAction()
                }
            Button(action: sendAction, label: {
                VStack(content: {
                    Image(systemName: "arrow.up.circle")
                    Text("send")
                }).clipShape(Circle())
                    
            })
        }
        
    }
    
}
func sendMsg(){
    print("text")
}
struct CustomInputView_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputView(text: "123")
    }
}
