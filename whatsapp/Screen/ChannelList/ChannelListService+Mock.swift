//
//  ChannelListService+Mock.swift
//  whatsapp
//
//  Created by 김수아 on 2/11/24.
//

import Foundation
import WANetworkAPI
import Combine

final class ChannelListServiceMock: ChannelListServiceable{
    func requestStatusChanges() -> AnyPublisher<WANetworkAPI.NetworkAPI.WebSocket.StatusChange.Response, Never> {
        return PassthroughSubject().eraseToAnyPublisher()
        // TODO: implement later
    }
    
    func requestChannels(page: Int, perPage: Int) async throws -> [Channel] {
        [
            Channel(
                id: "dng9iumsbfnk9d6wuhb5m4hoga",
                isActiveUser: true,
                senderId: "bmxkuy8r1bri5xwx64xhs1o8tw",
                senderProfileURL: URL(string: "\(ServerEnvironment.baseHttpURL.absoluteString)/api/v4/users/bmxkuy8r1bri5xwx64xhs1o8tw/image"),
                senderName: "alice2863",
                lastMessage: "alice2863 joined the channel.",
                lastMessageSentAt: Date(iso8601: "2024-02-11'T'06:05:58'Z'0000") ?? Date(),
                unreadMessageCount: 0
            ),
            Channel(
                id: "brx8ti5u5bdzud6n6afs6fufno",
                isActiveUser: true,
                senderId: "bmxkuy8r1bri5xwx64xhs1o8tw",
                senderProfileURL: URL(string: "\(ServerEnvironment.baseHttpURL.absoluteString)/api/v4/users/bmxkuy8r1bri5xwx64xhs1o8tw/image"),
                senderName: "alice2863",
                lastMessage: "alice2863 joined the channel.",
                lastMessageSentAt: Date(iso8601: "2024-02-11'T'06:05:58'Z'0000") ?? Date(),
                unreadMessageCount: 0
            )
        ]
    }
}
