//
//  File.swift
//
//
//  Created by 김수아 on 2/5/24.
//

import Foundation
import MetaCodable

extension NetworkAPI.Post{
    public enum GetForChannel {}
}

extension NetworkAPI.Post.GetForChannel{
    @Codable
    @MemberInit
    public struct Request{
        @CodedAt("channel_id")
        @IgnoreEncoding
        public let channelId: String
        
        @CodedAt("page")
        @Default(0)
        public let page: Int
        
        @CodedAt("per_page")
        @Default(60)
        public let perPage: Int
        
        @CodedAt("since")
        public let since: Int?
        
        @CodedAt("after")
        public let before: String?
        
        @CodedAt("after")
        public let after: String?
        
        @CodedAt("includeDeleted")
        @Default(false)
        public let includeDeleted: Bool
    }
    
    @Codable
    @MemberInit
    public struct Response{
        @CodedAt("order")
        public let order: [String]
        
        @CodedAt("posts")
        public let posts: [String: Post]
        
        @CodedAt("next_post_id")
        public let nextPostId: String
        
        @CodedAt("prev_post_id")
        public let prevPostId: String
        
        @CodedAt("has_next")
        public let hasNext: Bool
        
        @Codable
        @MemberInit
        public struct Post{
            @CodedAt("id")
            public let id: String
            
            @CodedAt("create_at")
            public let createAt: Int
            
            @CodedAt("update_at")
            public let updateAt: Int
            
            @CodedAt("delete_at")
            public let deleteAt: Int
            
            @CodedAt("edit_at")
            public let editAt: Int
            
            @CodedAt("user_id")
            public let userId: String
            
            @CodedAt("channel_id")
            public let channelId: String
            
            @CodedAt("root_id")
            public let rootId: String
            
            @CodedAt("original_id")
            public let originalId: String
            
            @CodedAt("message")
            public let message: String
            
            @CodedAt("type")
            public let type: String
            
            // FIXME:
//            @CodedAt("props")
//            public let props: [String: String]
            
            @CodedAt("hashtags")
            public let hashtags: String
            
            @CodedAt("file_ids")
            @Default([String]())
            public let fileIds: [String]
            
            @CodedAt("pending_post_id")
            public let pendingPostId: String
            
            @CodedAt("metadata")
            public let metadata: [String: String]
        }
    }
}
