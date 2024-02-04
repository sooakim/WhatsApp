//
//  File.swift
//  
//
//  Created by 김수아 on 2/5/24.
//

import Foundation
import MetaCodable

extension NetworkAPI.User{
    public enum GetUnreadMessages {}
}

extension NetworkAPI.User.GetUnreadMessages{
    @Codable
    @MemberInit
    public struct Request{
        @CodedAt("user_id")
        public let userId: String
        
        @CodedAt("channel_id")
        public let channel_id: String
    }
    
    @Codable
    @MemberInit
    public struct Response{
        @CodedAt("team_id")
        public let teamId: String
        
        @CodedAt("channel_id")
        public let channelId: String
        
        @CodedAt("msg_count")
        public let messageCount: Int
        
        @CodedAt("mention_count")
        public let mentionCount: Int
    }
}
