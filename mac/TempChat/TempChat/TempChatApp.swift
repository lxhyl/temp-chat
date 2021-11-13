//
//  TempChatApp.swift
//  TempChat
//
//  Created by candy on 2021/11/12.
//

import SwiftUI

@main
struct TempChatApp: App {
    
    var body: some Scene {
        WindowGroup {
            let webSoketHandle = WebSocketHandle()
            MainView(viewModel: webSoketHandle).frame(width: 500, height: 500)
        }
    }
}
