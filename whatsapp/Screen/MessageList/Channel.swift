//
//  Channel.swift
//  whatsapp
//
//  Created by 김수아 on 1/21/24.
//

import Foundation
import WANetworkAPI

struct Channel: Equatable, Identifiable{
    let id: String
    let createdAt: Int
    let updatedAt: Int
    let deletedAt: Int
    let teamId: String
    let type: String
    let displayName: String
    let name: String
    let header: String
    let purpose: String
    let lastPostedAt: Int
    let totalMessageCount: Int
    let extraUpdatedAt: Date
    let creatorId: String
    let teamDisplayName: String
    let teamName: String
    let teamUpdatedat: Date
    let policyId: String?
}

extension Channel{
    enum ChannelType{
        
    }
}

extension NetworkAPI.Channel.GetAll.Response{
    func asChannel() -> Channel{
        Channel(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            teamId: teamId,
            type: type,
            displayName: displayName,
            name: name,
            header: header,
            purpose: purpose,
            lastPostedAt: lastPostedAt,
            totalMessageCount: totalMessageCount,
            extraUpdatedAt: extraUpdatedAt,
            creatorId: creatorId,
            teamDisplayName: teamDisplayName,
            teamName: teamName,
            teamUpdatedat: teamUpdatedat,
            policyId: policyId
        )
    }
}
