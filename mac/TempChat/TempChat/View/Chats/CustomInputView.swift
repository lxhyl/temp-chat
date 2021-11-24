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
                .clipShape(RoundedRectangle(cornerRadius: 10))

            ZStack {
                Color.blue
                Image(systemName: "arrow.up.circle.fill")
                    .foregroundColor(.white).font(.largeTitle).imageScale(.large)

            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
                .frame(maxWidth: 100)
                .onTapGesture {
                    sendAction(text)
                    text = ""
                }
        }
        
        .padding(.horizontal,1)
            
    }
    
}

struct CustomInputView_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputView(text: "123",sendAction: {_ in })
    }
}
