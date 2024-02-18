//
//  File.swift
//  
//
//  Created by 김수아 on 2/18/24.
//

import Foundation
import MetaCodable

extension NetworkAPI.WebSocket{
    public enum ChannelCreated{}
}

extension NetworkAPI.WebSocket.ChannelCreated{
    @Codable
    @MemberInit
    public struct Response{
        @CodedAt("channel_id")
        public let channelId: String
        @CodedAt("team_id")
        public let teamId: String
    }
}
