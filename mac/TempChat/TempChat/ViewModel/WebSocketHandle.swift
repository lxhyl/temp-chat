//
//  WebSocketHandle.swift
//  TempChat
//
//  Created by candy on 2021/11/12.
//

import Foundation

class WebSocketDelegate: NSObject, URLSessionWebSocketDelegate {
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol1: String?) {
        print("Web socket did connect:\(String(describing: protocol1))")
    }
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("Web socket did disconnect")
    }
    

}

class WebSocketHandle {
    private let url = URL(fileURLWithPath: "ws://114.132.210.203:5002")
    //private let url = URL(fileURLWithPath: "ws://127.0.0.1")
    private let urlSession = URLSession(configuration: .default, delegate: WebSocketDelegate(), delegateQueue: OperationQueue())
    var WSTask: URLSessionWebSocketTask?
    init(){
    }
    
    func connect() {
        WSTask = urlSession.webSocketTask(with: url)
        WSTask?.resume()
    }
    
}

class ChatRoom: Identifiable, ObservableObject {
    private(set) var id: String
    private(set) var currentUserName: String
    @Published var messages: [MsgEntity] = []
    
    var webSocketHandle: WebSocketHandle
    init(roomId: String, currentUserName: String) {
        self.id = roomId
        self.currentUserName = currentUserName
        webSocketHandle = WebSocketHandle()
    }
    
    func joinRoom() {
        webSocketHandle.connect()
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let joinRoom = JoinRoom(roomid: id)
        let data = try! encoder.encode(joinRoom)
        sendMsg(data: data)
    }
    func leaveRoom() {
        webSocketHandle.WSTask?.cancel()
        
    }
    private func sendMsg(data: Data) {
        let message = URLSessionWebSocketTask.Message.data(data)
        webSocketHandle.WSTask?.send(message, completionHandler: { error in
            if let error = error {
                print(error)
            }
        })
    }
    func sendMsg(msg: String) {
        if msg == "" {
            return
        }
        let date = Int(Date().timeIntervalSince1970*1000)
        let msgEntity = MsgEntity(roomid: id, type: "text", data: msg, from: currentUserName, date: date)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonMsg = try! encoder.encode(msgEntity)
        let message = URLSessionWebSocketTask.Message.data(jsonMsg)
        webSocketHandle.WSTask?.send(message, completionHandler: { error in
            if let error = error {
                print(error)
            }
        })
    }
    
    func RecMsg() {
        webSocketHandle.WSTask?.receive() { result in
            switch result {
            case .success(let msg):
                switch msg {
                case .data(let datae):
                    print(datae)
                case .string(let string):
                    DispatchQueue.main.async {
                        self.messages.append(self.msgDecode(string.data(using: .utf8)!))
                    }
                @unknown default:
                    print("unknow fault")
                }
            case .failure(let error):
                print(error)
            }
            self.RecMsg()
        }
    }
    
    func msgDecode(_ data: Data) -> MsgEntity{
        let decoder = JSONDecoder()
        let msg = try! decoder.decode(MsgEntity.self, from: data)
        return msg
    }
}

class ViewModel: ObservableObject {
    @Published private(set) var chatRooms: [ChatRoom] = []
    init() { }
    func vJoinRoom(roomId id: String, currentUserName: String) {
        if id == "" || currentUserName == "" {
            return
        }
        if chatRooms.contains(where: { $0.id == id }) {
            print("have same roodId")
            return
        }
        let room = ChatRoom(roomId: id, currentUserName: currentUserName)
        room.joinRoom()
        room.RecMsg()
        chatRooms.append(room)
    }
}

