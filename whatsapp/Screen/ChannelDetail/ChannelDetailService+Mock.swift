//
//  ChannelDetailService+Mock.swift
//  whatsapp
//
//  Created by 김수아 on 2/25/24.
//

import Foundation

final class ChannelDetailServiceMock: ChannelDetailServiceable{
    func requestPosts(channelId: String, beforeId: String?) async throws -> RequestPostListResponse {
        // TODO: implement later
        return ([], nil)
    }
}
