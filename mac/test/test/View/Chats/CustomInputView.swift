//
//  CustomInputView.swift
//  test
//
//  Created by candy on 2021/11/11.
//

import SwiftUI

struct CustomInputView: View {
    @State var text: String
    var action: () -> Void = sendMsg
    var body: some View {
        HStack{
            TextEditor(text: $text)
            Button(action: action, label: {
                Text("send")
            })
        }
        
    }
    
}
func sendMsg(){
    print("111")
}
struct CustomInputView_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputView(text: "123")
    }
}
