//
//  MainView.swift
//  TempChat
//
//  Created by candy on 2021/11/12.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel: ViewModel = ViewModel()
    @State var a = "dasdasfas"
    var body: some View {
        NavigationView {
            List(0..<viewModel.chatRooms.count, id: \.self) { n in
                NavigationLink(destination: ChatWindowView(chatRoom: viewModel.chatRooms[n]), isActive: $viewModel.isChatActive[n]) {
                    Label(viewModel.chatRooms[n].id, systemImage: "person.3.fill")

                }
            }
            .toolbar {
                ControlGroup {
                    Button(action: {
                        if let n = viewModel.isChatActive.firstIndex(of: true){ viewModel.isChatActive[n] = false }
                    }, label: {
                        Label("add", systemImage: "plus")
                    })
                }
//                ToolbarItem {
//                    Button(action: {
//                        if let n = viewModel.isChatActive.firstIndex(of: true){ viewModel.isChatActive[n] = false }
//                    }, label: {
//                        Label("add", systemImage: "plus")
//                    })
//                }
            }
            if !viewModel.isChatActive.contains(true) {
                NewSessionView(join: viewModel.vJoinRoom)
            }
        }
    }
}
//func getLogEntries() throws -> [OSLogEntryLog] {
//    // Open the log store.
//    let logStore = try OSLogStore(scope: .currentProcessIdentifier)
//    // Get all the logs from the last hour.
//    let oneHourAgo = logStore.position(timeIntervalSinceLatestBoot: 0)
//
//    // Fetch log objects.
//    let allEntries = try logStore.getEntries(at: oneHourAgo)
//
//    // Filter the log to be relevant for our specific subsystem
//    // and remove other elements (signposts, etc).
//    return allEntries
//        .compactMap { $0 as? OSLogEntryLog }
//}
//func isFirstIsHanZi(str: String) -> Bool {
//    return str.first ?? "a"  > "\u{4E00}" && str.first ?? "a" < "\u{9FA5}"
//}

/*
struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        let websocketHandle = WebSocketHandle()
        MainView(viewModel: websocketHandle)
    }
}*/
