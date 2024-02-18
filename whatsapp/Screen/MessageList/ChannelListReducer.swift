//
//  ChannelListReducer.swift
//  whatsapp
//
//  Created by 김수아 on 1/21/24.
//

import Foundation
import ComposableArchitecture
import WANetworkAPI
import Combine

@Reducer
struct ChannelListReducer{
    @Dependency(\.service) var service
    
    struct State{
        var channels: [Channel] = []
        var channelIndexesByUserId: [String: [Int]] = [:]
    }
    
    enum Action{
        case attachEventListener
        case detachEventListener
        case loadAll
        case updateChannels([Channel])
        case updateSenderStatus(isActiveUser: Bool, userId: String)
        case error(Error)
    }
    
    var body: some Reducer<State, Action> {
        Reduce{ state, action in
            switch action{
            case .attachEventListener:
                return .run{ send in
                    let publisher = AsyncPublisher(service.channelListService.requestStatusChanges())
                    for await statusChange in publisher{
                        await send(.updateSenderStatus(
                            isActiveUser: statusChange.status == "online",
                            userId: statusChange.userId
                        ))
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
                
                //indexing...
                var channelIndexesByUserId: [String: [Int]] = [:]
                for (index, channel) in channels.enumerated(){
                    guard let senderId = channel.senderId else{ continue }
                    var channels = channelIndexesByUserId[senderId, default: []]
                    channels.append(index)
                    channelIndexesByUserId[senderId] = channels
                }
                state.channelIndexesByUserId = channelIndexesByUserId
            case let .updateSenderStatus(isActiveUser, userId):
                let targetIndexes = Set(state.channelIndexesByUserId[userId, default: []])
    
                state.channels = state.channels.enumerated().map { index, channel in
                    guard targetIndexes.contains(index) else{ return channel }
                    var newChannel = channel
                    newChannel.isActiveUser = isActiveUser
                    return newChannel
                }
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
