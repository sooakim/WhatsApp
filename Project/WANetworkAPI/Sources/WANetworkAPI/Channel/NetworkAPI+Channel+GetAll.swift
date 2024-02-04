//
//  Channel.swift
//
//
//  Created by 김수아 on 1/21/24.
//

import Foundation
import MetaCodable

public extension NetworkAPI.Channel{
    enum GetAll {}
}

extension NetworkAPI.Channel.GetAll{
    @Codable
    @MemberInit
    public struct Request{
        @CodedAt("not_associated_to_group")
        @Default("")
        public let notAssociatedToGroup: String
        
        @CodedAt("page")
        @Default(0)
        public let page: Int
        
        @CodedAt("per_page")
        @Default(10)
        public let perPage: Int
        
        @CodedAt("exclude_default_channels")
        @Default(false)
        public let excludeDefaultChannels: Bool
        
        @CodedAt("include_deleted")
        @Default(false)
        public let includeDeleted: Bool
        
        @CodedAt("include_total_count")
        @Default(false)
        public let includeTotalCount: Bool
        
        @CodedAt("exclude_policy_constrained")
        @Default(false)
        public let excludePolicyConstrained: Bool
    }
    
    @Codable
    @MemberInit
    public struct Response{
        @CodedAt("id")
        public let id: String
        
        @CodedAt("create_at")
        public let createdAt: Int
        
        @CodedAt("update_at")
        public let updatedAt: Int
        
        @CodedAt("delete_at")
        public let deletedAt: Int
        
        @CodedAt("team_id")
        public let teamId: String
        
        @CodedAt("type")
        public let type: ChannelType
        
        @CodedAt("display_name")
        public let displayName: String
        
        @CodedAt("name")
        public let name: String
        
        @CodedAt("header")
        public let header: String
        
        @CodedAt("purpose")
        public let purpose: String
        
        @CodedAt("last_post_at")
        public let lastPostedAt: Int
        
        @CodedAt("total_msg_count")
        public let totalMessageCount: Int
        
        @CodedAt("extra_update_at")
        public let extraUpdatedAt: Date
        
        @CodedAt("creator_id")
        public let creatorId: String
        
        @CodedAt("team_display_name")
        public let teamDisplayName: String
        
        @CodedAt("team_name")
        public let teamName: String
        
        @CodedAt("team_update_at")
        public let teamUpdatedat: Date
        
        @CodedAt("policy_id")
        public let policyId: String?
    }
}

extension NetworkAPI.Channel.GetAll.Response{
    public enum ChannelType: String, Codable{
        case P, G, O, D
    }
}
