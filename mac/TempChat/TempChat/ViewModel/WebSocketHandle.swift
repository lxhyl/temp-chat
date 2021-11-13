//
//  WebSocketHandle.swift
//  TempChat
//
//  Created by candy on 2021/11/12.
//

import Foundation


class WebSocketHandle: ObservableObject {
    static let url = URL(fileURLWithPath: "ws://114.132.210.203:5002")
    static let urlSession = URLSession(configuration: .default)
    var webSocketTask: URLSessionWebSocketTask
    @Published var chatTable: Array<String> = []
    init() {
        
        self.webSocketTask = WebSocketHandle.urlSession.webSocketTask(with: WebSocketHandle.url)
        self.webSocketTask.resume()
        DispatchQueue.global().async {
            while true {
                self.webSocketTask.receive(completionHandler: self.RecHandle)
                sleep(1)
            }
        }
    }
    
    func joinChat(roomId: String) {
        if self.chatTable.contains(roomId) {
            return
        }
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let joinRoom = JoinRoom(roomid: roomId)
        let data = try? encoder.encode(joinRoom)
        
        let msg = URLSessionWebSocketTask.Message.data(data!)
        webSocketTask.send(msg) { error in
            if let e = error {
                print(e)
            }else {
                self.chatTable.append(roomId)
                print(self.chatTable)
            }
        }
        
    }
    
    func RecHandle(result: Result<URLSessionWebSocketTask.Message, Error>) {
        switch result {
        case .success(let msg):
            switch msg {
            case .data(let data):
                print(String(data: data, encoding: .utf8)!)
            case .string(let string):
                print(string)
            @unknown default:
                print("unknow fault")
            }
        case .failure(let error):
            print(error)
        }
    }
    func sendMsg() {
        
    }
}

