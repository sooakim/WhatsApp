//
//  Channel.swift
//
//
//  Created by 김수아 on 1/21/24.
//

import Foundation

public extension NetworkAPI.Channel{
    struct GetAllRequest: Encodable{
        public let notAssociatedToGroup: String
        public let page: Int
        public let perPage: Int
        public let excludeDefaultChannels: Bool
        public let includeDeleted: Bool
        public let includeTotalCount: Bool
        public let excludePolicyConstrained: Bool
        
        public init(
            notAssociatedToGroup: String = "",
            page: Int = 0,
            perPage: Int = 20,
            excludeDefaultChannels: Bool = false,
            includeDeleted: Bool = false,
            includeTotalCount: Bool = false,
            excludePolicyConstrained: Bool = false
        ) {
            self.notAssociatedToGroup = notAssociatedToGroup
            self.page = page
            self.perPage = perPage
            self.excludeDefaultChannels = excludeDefaultChannels
            self.includeDeleted = includeDeleted
            self.includeTotalCount = includeTotalCount
            self.excludePolicyConstrained = excludePolicyConstrained
        }
        
        enum CodingKeys: String, CodingKey{
            case notAssociatedToGroup = "not_associated_to_group"
            case page = "page"
            case perPage = "per_page"
            case excludeDefaultChannels = "exclude_default_channels"
            case includeDeleted = "include_deleted"
            case includeTotalCount = "include_total_count"
            case excludePolicyConstrained = "exclude_policy_constrained"
        }
    }
}

public extension NetworkAPI.Channel{
    struct GetAllResponse: Decodable{
        public let id: String
        public let createdAt: Int
        public let updatedAt: Int
        public let deletedAt: Int
        public let teamId: String
        public let type: String
        public let displayName: String
        public let name: String
        public let header: String
        public let purpose: String
        public let lastPostedAt: Int
        public let totalMessageCount: Int
        public let extraUpdatedAt: Date
        public let creatorId: String
        public let teamDisplayName: String
        public let teamName: String
        public let teamUpdatedat: Date
        public let policyId: String
        
        enum CodigKeys: String, CodingKey{
            case id = "id"
            case createdAt = "create_at"
            case updatedAt = "update_at"
            case deletedAt = "delete_at"
            case teamId = "team_id"
            case type = "type"
            case displayName = "display_name"
            case name = "name"
            case header = "header"
            case purpose = "purpose"
            case lastPostedAt = "last_post_at"
            case totalMessageCount = "total_msg_count"
            case extraUpdatedAt = "extra_update_at"
            case creatorId = "creator_id"
            case teamDisplayName = "team_display_name"
            case teamName = "team_name"
            case teamUpdatedat = "team_update_at"
            case policyId = "policy_id"
        }
    }
}
