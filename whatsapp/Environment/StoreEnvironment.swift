//
//  StoreEnvironment.swift
//  whatsapp
//
//  Created by 김수아 on 1/21/24.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct StoreEnvironmentKey: EnvironmentKey{
    static let defaultValue = StoreEnvironment()
}

extension EnvironmentValues{
    var store: StoreEnvironment{
        get{ self[StoreEnvironmentKey.self] }
        set{ self[StoreEnvironmentKey.self] = newValue }
    }
}

struct StoreEnvironment{
    let channelList = Store(initialState: ChannelListReducer.State()) {
        ChannelListReducer()
    }
    let login = Store(initialState: LoginReducer.State()) {
        LoginReducer()
    }
    let main = Store(initialState: MainReducer.State.loggedOut(.init())) {
        MainReducer()
    }
    let home = Store(initialState: HomeReducer.State()) {
        HomeReducer()
    }
}
