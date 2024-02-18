//
//  File.swift
//  
//
//  Created by 김수아 on 2/18/24.
//

import Foundation
import MetaCodable

extension NetworkAPI.WebSocket{
    public enum StatusChange{}
}

extension NetworkAPI.WebSocket.StatusChange{
    @Codable
    @MemberInit
    public struct Response{
        @CodedAt("status")
        public let status: String
        @CodedAt("user_id")
        public let userId: String
        
        public enum Status: String, Codable{
            case away
            case online
            case offline
            case doNotDisturb = "do_not_disturb"
        }
    }
}
