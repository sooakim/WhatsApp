//
//  ServierDependency.swift
//  whatsapp
//
//  Created by 김수아 on 2/4/24.
//

import Foundation
import ComposableArchitecture

struct ServiceDependency{
    let loginService: LoginServiceable
    let channelListService: ChannelListServiceable
    let channelDetailService: ChannelDetailServiceable
}

extension ServiceDependency: DependencyKey{
    static var liveValue: ServiceDependency = Self(
        loginService: LoginService(),
        channelListService: ChannelListService(),
        channelDetailService: ChannelDetailService()
    )
    static var previewValue: ServiceDependency = .mock
    static var testValue: ServiceDependency = .mock
}

extension DependencyValues{
    var service: ServiceDependency{
        get{ self[ServiceDependency.self] }
        set{ self[ServiceDependency.self] = newValue }
    }
}
