//
//  File.swift
//  
//
//  Created by 김수아 on 2/18/24.
//

import Foundation
import MetaCodable

public struct WebSocketResponse<Data: Decodable>: Decodable{
    public let event: WebSocketEvent
    public let data: Data
    public let broadcast: Broadcast
    public let seq: Int
    
    @Codable
    public struct Broadcast{
        @CodedAt("omit_users")
        public let omitUsers: [String]?
        @CodedAt("user_id")
        public let userId: String
        @CodedAt("team_id")
        public let teamId: String
        @CodedAt("connection_id")
        public let connectionId: String
        @CodedAt("omit_connection_id")
        public let omitConnectionId: String
    }
}

public extension WebSocketResponse{
    init?(from receivedMessage: WebSocketManager.Message){
        guard
            case let .string(receivedJson) = receivedMessage,
            let receivedData = receivedJson.data(using: .utf8),
            let received = try? JSONDecoder.shared.decode(Self.self, from: receivedData)
        else{ return nil }
        
        self = received
    }
}
