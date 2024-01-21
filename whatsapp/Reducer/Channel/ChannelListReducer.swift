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
                    let request = NetworkAPI.Channel.GetAllRequest()
                    do{
                        let responses: [NetworkAPI.Channel.GetAllResponse] = try await NetworkAPI.Channel.request(.getAll(request))
                        return await send(.updateChannels(responses.map{ $0.asChannel() }))
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
