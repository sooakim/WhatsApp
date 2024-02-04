//
//  File.swift
//
//
//  Created by 김수아 on 2/5/24.
//

import Foundation
import MetaCodable

public extension NetworkAPI.User{
    enum GetStatus {}
}

extension NetworkAPI.User.GetStatus{
    @Codable
    @MemberInit
    public struct Request{
        @CodedAt("user_id")
        public let userId: String
    }
    
    @Codable
    @MemberInit
    public struct Response{
        @CodedAt("user_id")
        public let userId: String
        
        @CodedAt("status")
        public let status: UserStatus
        
        @CodedAt("manual")
        public let manual: Bool
        
        @CodedAt("last_activity_at")
        public let lastActivityAt: Int
    }
}

extension NetworkAPI.User.GetStatus.Response{
    public enum UserStatus: String, Codable{
        case online
        case away
        case offline
        case dnd
    }
}
