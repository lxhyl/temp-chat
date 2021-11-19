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
            ZStack {
                Color.blue
                Image(systemName: "arrow.up.circle.fill").font(.largeTitle).imageScale(.large)
            }.frame(maxWidth: 100)
                .onTapGesture {
                    sendAction(text)
                    text = ""
                }
        }
        
    }
    
}
/*
struct CustomInputView_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputView(text: "123")
    }
}*/
