//
//  File.swift
//  
//
//  Created by 김수아 on 2/18/24.
//

import Foundation
import MetaCodable

extension NetworkAPI.Post{
    public enum CreatePost{}
}

extension NetworkAPI.Post.CreatePost{
    @Codable
    @MemberInit
    public struct Request{
        public let channelId: String
        public let message: String
        public let rootId: String?
        public let fileIds: [String]
        public let props: [String: String]
        public let metadata: Metadata
        
        @Codable
        @MemberInit
        public struct Metadata{
            public let priority: Priority
            
            @Codable
            @MemberInit
            public struct Priority{
                public let priority: String
                public let requestedAck: Bool
            }
        }
    }
    
    @Codable
    @MemberInit
    public struct Response{
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
        @CodedAt("props")
        public let props: [String: String]
        @CodedAt("hashtag")
        public let hashtag: String
        @CodedAt("fileIds")
        public let fileIds: [String]
        @CodedAt("pending_post_id")
        public let pendingPostId: String
        @CodedAt("metadata")
        public let metadata: Metadata
        
        @Codable
        @MemberInit
        public struct Metadata{
            @CodedAt("embeds")
            public let embeds: [Embed]
            @CodedAt("emojis")
            public let emojis: [Emoji]
            @CodedAt("files")
            public let files: [File]
            @CodedAt("images")
            public let images: [Image]
            @CodedAt("reactions")
            public let reactions: [Reaction]
            @CodedAt("priority")
            public let priority: Priority
            @CodedAt("acknowledgements")
            public let acknowledgements: [Acknowledgement]
            
            @Codable
            @MemberInit
            public struct Embed{
                @CodedAt("type")
                public let type: String
                @CodedAt("url")
                public let url: String
                @CodedAt("data")
                public let data: [String: String]
            }
            
            @Codable
            @MemberInit
            public struct Emoji{
                @CodedAt("id")
                public let id: String
                @CodedAt("creator_id")
                public let creatorId: String
                @CodedAt("name")
                public let name: String
                @CodedAt("create_at")
                public let createAt: Int
                @CodedAt("update_at")
                public let updateAt: Int
                @CodedAt("delete_at")
                public let deleteAt: Int
            }
            
            @Codable
            @MemberInit
            public struct File{
                @CodedAt("id")
                public let id: String
                @CodedAt("user_id")
                public let userId: String
                @CodedAt("post_id")
                public let postId: String
                @CodedAt("create_at")
                public let createAt: Int
                @CodedAt("update_at")
                public let updateAt: Int
                @CodedAt("delete_at")
                public let deleteAt: Int
                @CodedAt("name")
                public let name: String
                @CodedAt("ext")
                public let ext: String
                @CodedAt("size")
                public let size: Int
                @CodedAt("mime_type")
                public let mimeType: String
                @CodedAt("width")
                public let width: Int
                @CodedAt("height")
                public let height: Int
                @CodedAt("has_preview_image")
                public let hasPreviewImage: Bool
            }
            
            @Codable
            @MemberInit
            public struct Image{
                
            }
            
            @Codable
            @MemberInit
            public struct Reaction{
                @CodedAt("user_id")
                public let userId: String
                @CodedAt("post_id")
                public let postId: String
                @CodedAt("emoji_name")
                public let emojiName: String
                @CodedAt("create_at")
                public let createAt: Int
            }
            
            @Codable
            @MemberInit
            public struct Priority{
                @CodedAt("priority")
                public let priority: String
                @CodedAt("requested_ack")
                public let requestedAck: Bool
            }
            
            @Codable
            @MemberInit
            public struct Acknowledgement{
                @CodedAt("user_id")
                public let userId: String
                @CodedAt("post_id")
                public let postId: String
                @CodedAt("acknowledged_at")
                public let acknowledgedAt: Int
            }
        }
    }
}
