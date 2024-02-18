//
//  File.swift
//
//
//  Created by 김수아 on 2/18/24.
//

import Foundation
import MetaCodable

extension NetworkAPI.WebSocket{
    public enum Auth: WebSocketProvidable{
        @discardableResult
        public static func request(_ request: Request) async throws -> Response {
            guard let token = Keychain["token"] else{
                throw Error.tokenRequired
            }
            WebSocketManager.shared.connectIfNeeded()

            let webSocketRequest = WebSocketRequest(seq: sequence, action: .authenticationChallenge, data: ["token": token])
            let json = String(data: try JSONEncoder.shared.encode(webSocketRequest), encoding: .utf8) ?? ""
            try await WebSocketManager.shared.send(with: .string(json))
            
            while !Task.isCancelled{
                guard 
                    let receivedMessage = try await WebSocketManager.shared.receive(),
                    let webSocketResponse = WebSocketResponse<Response>(from: receivedMessage)
                else{ continue }
              
                guard webSocketResponse.seq == 0 else{ continue }
                return webSocketResponse.data
            }
            throw Error.invalidResponse
        }
    }
}

extension NetworkAPI.WebSocket.Auth{
    @Codable
    @MemberInit
    public struct Request{
        
    }
    
    @Codable
    @MemberInit
    public struct Response{
        @CodedAt("connection_id")
        public let connectionId: String
        @CodedAt("server_version")
        public let serverVersion: String
    }
    
    public enum Error: Swift.Error{
        case tokenRequired
        case invalidResponse
    }
}
