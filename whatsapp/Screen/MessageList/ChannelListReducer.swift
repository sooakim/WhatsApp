//
//  ChannelListReducer.swift
//  whatsapp
//
//  Created by 김수아 on 1/21/24.
//

import Foundation
import ComposableArchitecture
import WANetworkAPI

@Reducer
struct ChannelListReducer{
    @Dependency(\.service) var service
    
    struct State{
        var channels: [Channel] = []
    }
    
    enum Action{
        case loadAll
        case updateChannels([Channel])
        case error(Error)
    }
    
    var body: some Reducer<State, Action> {
        Reduce{ state, action in
            switch action{
            case .loadAll:
                return .run{ send in
                    do{
                        let channels = try await service.channelListService.requestChannels()
                        return await send(.updateChannels(channels))
                    }catch{
                        return await send(.error(error))
                    }
                }
            case let .updateChannels(channels):
                state.channels = channels
            case .error:
                break
            }
            return .none
        }
    }
}
