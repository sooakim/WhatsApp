//
//  ServiceDependency+Mock.swift
//  whatsapp
//
//  Created by 김수아 on 2/11/24.
//

import Foundation

extension ServiceDependency{
    static let mock = ServiceDependency(
        loginService: LoginService(),
        channelListService: ChannelListServiceMock(),
        channelDetailService: ChannelDetailServiceMock()
    )
}
