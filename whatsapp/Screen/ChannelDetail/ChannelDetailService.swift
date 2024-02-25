//
//  ChannelDetailService.swift
//  whatsapp
//
//  Created by 김수아 on 2/25/24.
//

import Foundation
import Combine
import WANetworkAPI

protocol ChannelDetailServiceable{
    typealias RequestPostListResponse = ([PostInChannel], prevPostId: String?)
    
    func requestPosts(channelId: String, beforeId: String?) async throws -> RequestPostListResponse
}

struct ChannelDetailService: ChannelDetailServiceable{
    func requestPosts(channelId: String, beforeId: String?) async throws -> RequestPostListResponse {
        let response: NetworkAPI.Post.GetForChannel.Response = try await NetworkAPI.Post.request(.getForChannel(.init(channelId: channelId, before: beforeId)))
        return (
            response.order.lazy
                .compactMap{ response.posts[$0] }
                .map(PostInChannel.init(_:)),
            prevPostId: response.prevPostId
        )
    }
}

private extension PostInChannel{
    init(_ post: NetworkAPI.Post.GetForChannel.Response.Post){
        self.init(
            id: post.id,
            updatedAt: Date(timeIntervalSince1970: TimeInterval(post.updateAt / 1000)),
            deleteAt: Date(timeIntervalSince1970: TimeInterval(post.deleteAt / 1000)),
            senderId: post.userId,
            message: post.message
        )
    }
}
