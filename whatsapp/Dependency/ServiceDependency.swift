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
}

extension ServiceDependency: DependencyKey{
    static var liveValue: ServiceDependency = Self(
        loginService: LoginService(),
        channelListService: ChannelListService()
    )
}

extension DependencyValues{
    var service: ServiceDependency{
        get{ self[ServiceDependency.self] }
        set{ self[ServiceDependency.self] = newValue }
    }
}
