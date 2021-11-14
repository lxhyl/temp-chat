//
//  MsgEntity.swift
//  TempChat
//
//  Created by candy on 2021/11/12.
//

import Foundation

struct MsgEntity: Codable{
    var roomid: String
    var type: String
    var data: String
    var from: String
    var date: Int
}

struct JoinRoom: Codable {
    var roomid: String
    var type: String = "connect"
}
