//
//  File.swift
//
//
//  Created by 김수아 on 2/4/24.
//

import Foundation
import MetaCodable

public extension NetworkAPI.Channel.Member{
    enum GetAll {}
}

extension NetworkAPI.Channel.Member.GetAll{
    @Codable
    @MemberInit
    public struct Request{
        @CodedAt("page")
        @Default(0)
        public let page: Int
        
        @CodedAt("per_page")
        @Default(60)
        public let perPage: Int
    }
    
    @Codable
    @MemberInit
    public struct Response{
        @CodedAt("channel_id")
        public let channelId: String
        
        @CodedAt("user_id")
        public let userId: String
        
        @CodedAt("roles")
        public let roles: String
        
        @CodedAt("last_viewed_at")
        public let lastViewedAt: Int
        
        @CodedAt("msg_count")
        public let msgCount: Int
        
        @CodedAt("mention_count")
        public let mentionCount: Int
        
        @CodedAt("notify_props")
        public let notifyProps: NotifyProps
        
        @CodedAt("last_update_at")
        public let lastUpdateAt: Int
    }
}

extension NetworkAPI.Channel.Member.GetAll.Response{
    @Codable
    @MemberInit
    public struct NotifyProps{
        @CodedAt("email")
        public let email: String
        
        @CodedAt("push")
        public let push: String
        
        @CodedAt("desktop")
        public let desktop: String
        
        @CodedAt("mark_unread")
        public let mark_unread: String
    }
}
