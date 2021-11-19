//
//  WebSocketHandle.swift
//  TempChat
//
//  Created by candy on 2021/11/12.
//

import Foundation
import OSLog


class WebSocketDelegate: NSObject, URLSessionWebSocketDelegate {
    var isConnected = false
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol1: String?) {
        isConnected = true
        os_log("连接服务器成功")
    }
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        isConnected = false
        os_log("连接服务器失败or断开链接")
    }
}

class ChatRoom: Identifiable, ObservableObject {
    
    private let urlSession: URLSession
    static private let url = URL(fileURLWithPath: "ws://114.132.210.203:5002")
    //static private let url = URL(fileURLWithPath: "ws://127.0.0.1")
    
    private(set) var id: String
    private(set) var currentUserName: String
    private var webSocket: URLSessionWebSocketTask
    private var webSocketDelegate: WebSocketDelegate
    @Published var messages: [MsgEntity] = []
    
    init(roomId: String, currentUserName: String) {
        self.id = roomId
        self.currentUserName = currentUserName
        
        webSocketDelegate = WebSocketDelegate()
        urlSession = URLSession(configuration: .default, delegate: webSocketDelegate, delegateQueue: OperationQueue())
        webSocket = urlSession.webSocketTask(with: ChatRoom.url)
        webSocket.resume()        
    }
    func joinRoom() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let joinRoom = JoinRoom(roomid: id)
        let data = try! encoder.encode(joinRoom)
        sendMsgToJoinRoom(data: data)
    }
    func leaveRoom() {
        webSocket.cancel()
    }
    private func sendMsgToJoinRoom(data: Data) {
        let message = URLSessionWebSocketTask.Message.data(data)
        webSocket.send(message) { error in
            if let _ = error {
                self.webSocketDelegate.isConnected = false
            }
        }
    }
    func sendMsg(msg: String) {
        if msg == "" { return }
        let message = URLSessionWebSocketTask.Message.data(msgEncode(msg: msg))
        webSocket.send(message) { error in
            if let _ = error { os_log("消息发送失败") }
        }
    }
    
    func RecMsg() {
        webSocket.receive() { [self] result in
            switch result {
            case .success(let msg):
                switch msg {
                case .data(let datae):
                    print(datae)
                case .string(let string):
                    DispatchQueue.main.async {
                        messages.append(msgDecode(string.data(using: .utf8)!))
                    }
                @unknown default:
                    os_log("unknow fault")
                }
            case .failure:
                webSocketDelegate.isConnected = false
                return
            }
            self.RecMsg()
        }
    }
    
    func msgDecode(_ data: Data) -> MsgEntity{
        let decoder = JSONDecoder()
        let msg = try! decoder.decode(MsgEntity.self, from: data)
        return msg
    }
    func msgEncode(msg: String) -> Data{
        let date = Int(Date().timeIntervalSince1970*1000)
        let msgEntity = MsgEntity(roomid: id, type: "text", data: msg, from: currentUserName, date: date)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonMsg = try! encoder.encode(msgEntity)
        return jsonMsg
    }
}

class ViewModel: ObservableObject {
    @Published var chatRooms: [ChatRoom] = []
    @Published var isChatActive: [Bool] = []
    @Published var isShowLog = false
    @Published var logs: [String] = []
    init() {
    }
    func vJoinRoom(roomId id: String, currentUserName: String) {
        if id == "" || currentUserName == "" {
            return
        }
        if chatRooms.contains(where: { $0.id == id }) {
            return
        }
        let room = ChatRoom(roomId: id, currentUserName: currentUserName)
        room.RecMsg()
        room.joinRoom()
        chatRooms.append(room)
        isChatActive.append(true)
    }
}

