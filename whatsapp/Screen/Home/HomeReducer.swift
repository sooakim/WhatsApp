//
//  HomeReducer.swift
//  whatsapp
//
//  Created by 김수아 on 2/25/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct HomeReducer{
    struct State{
        var tab1 = ChannelListReducer.State()
        var tab2 = ChannelListReducer.State()
        var tab3 = ChannelListReducer.State()
        var tab4 = ChannelListReducer.State()
    }
    
    enum Action{
        case tab1(ChannelListReducer.Action)
        case tab2(ChannelListReducer.Action)
        case tab3(ChannelListReducer.Action)
        case tab4(ChannelListReducer.Action)
    }
    
    var body: some Reducer<State, Action>{
        Scope(state: \.tab1, action: \.tab1) {
            ChannelListReducer()
        }
        Scope(state: \.tab2, action: \.tab2) {
            ChannelListReducer()
        }
        Scope(state: \.tab3, action: \.tab3) {
            ChannelListReducer()
        }
        Scope(state: \.tab4, action: \.tab4) {
            ChannelListReducer()
        }
    }
}

