//
//  ChannelListService.swift
//  whatsapp
//
//  Created by 김수아 on 2/4/24.
//

import Foundation
import WANetworkAPI
import WAFoundation

protocol ChannelListServiceable{
    func requestChannels() async throws -> [Channel]
}

struct ChannelListService: ChannelListServiceable{
    func requestChannels() async throws -> [Channel] {
        let channelRequest = NetworkAPI.Channel.GetAll.Request()
        let channels: [NetworkAPI.Channel.GetAll.Response] = try await NetworkAPI.Channel.request(.getAll(channelRequest))
        let channelMembers = try await channels.asyncMap{ (channel) -> [NetworkAPI.Channel.Member.GetAll.Response] in
            let channelMemberRequest = NetworkAPI.Channel.Member.GetAll.Request(perPage: 1)
            return try await NetworkAPI.Channel.Member.request(.getAll(channelId: channel.id, channelMemberRequest))
        }
        return channels.enumerated().map{ (index, channel) in
            let channelMembers = channelMembers[index]
            return Channel(
                id: channel.id,
                //FIXME: later
                isActiveUser: false,
                senderProfileURL: URL(string: "http://118.67.134.127:8065/api/v4/users/\(channelMembers.first?.userId ?? "")/image"),
                senderName: channelMembers.first?.userId ?? "",
                lastMessage: channel.displayName,
                lastMessageSentAt: Date.init(timeIntervalSince1970: TimeInterval(channel.lastPostedAt)),
                unreadMessageCount: channel.totalMessageCount
            )
        }
    }
}
