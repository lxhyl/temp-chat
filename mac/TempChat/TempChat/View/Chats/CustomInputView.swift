//
//  CustomInputView.swift
//  test
//
//  Created by candy on 2021/11/11.
//

import SwiftUI

struct CustomInputView: View {
    @State var text: String = ""
    var sendAction: (String) -> Void
    var body: some View {
        HStack{
            TextEditor(text: $text)
                .onSubmit {
                    sendAction(text)
                    text = ""
                }
            Button(action: {sendAction(text);text = ""}, label: {
                VStack(content: {
                    Image(systemName: "arrow.up.circle")
                    Text("send")
                }).clipShape(Circle())
                    
            })
        }
        
    }
    
}
/*
struct CustomInputView_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputView(text: "123")
    }
}*/
