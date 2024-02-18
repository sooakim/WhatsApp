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
        case attachEventListener
        case detachEventListener
        case loadAll
        case updateChannels([Channel])
        case error(Error)
    }
    
    var body: some Reducer<State, Action> {
        Reduce{ state, action in
            switch action{
            case .attachEventListener:
                return .run{ send in
                    do{
                        try await service.channelListService.requestStatusChanges()
                    }catch{
                        print(error)
                        return await send(.error(error))
                    }
                }.cancellable(id: CancelId.eventListener)
            case .detachEventListener:
                return .cancel(id: CancelId.eventListener)
            case .loadAll:
                return .run{ send in
                    do{
                        let channels = try await service.channelListService.requestChannels()
                        return await send(.updateChannels(channels))
                    }catch{
                        print(error)
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
    
    private enum CancelId{
        case eventListener
    }
}
