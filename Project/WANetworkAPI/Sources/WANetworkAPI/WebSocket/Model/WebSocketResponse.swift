//
//  File.swift
//  
//
//  Created by 김수아 on 2/18/24.
//

import Foundation
import MetaCodable

struct WebSocketResponse<Data: Decodable>: Decodable{
    let event: WebSocketEvent
    let data: Data
    let broadcast: Broadcast
    let seq: Int
    
    @Codable
    struct Broadcast{
        @CodedAt("omit_users")
        let omitUsers: [String]?
        @CodedAt("user_id")
        let userId: String
        @CodedAt("team_id")
        let teamId: String
        @CodedAt("connection_id")
        let connectionId: String
        @CodedAt("omit_connection_id")
        let omitConnectionId: String
    }
}
