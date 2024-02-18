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
        var channelPage: Int = 0
        var channels: [Channel] = []
        var channelIndexesByUserId: [String: [Int]] = [:]
    }
    
    enum Action{
        // MARK: - Public Action
        case attachEventListener
        case detachEventListener
        case refetch
        case loadAll
        case scrolledToBottom
        
        // MARK: - Internal Action
        case updateChannelPage(Int)
        case updateChannels([Channel])
        case insertChannels([Channel])
        case updateSenderStatus(isActiveUser: Bool, userId: String)
        case error(Error)
    }
    
    var body: some Reducer<State, Action> {
        Reduce{ state, action in
            switch action{
            case .attachEventListener:
                return .merge(
                    .run{ send in
                        let publisher = AsyncPublisher(service.channelListService.requestStatusChanges())
                        for await statusChange in publisher{
                            await send(.updateSenderStatus(
                                isActiveUser: statusChange.status == "online",
                                userId: statusChange.userId
                            ))
                        }
                    }
                ).cancellable(id: CancelId.eventListener)
            case .detachEventListener:
                return .cancel(id: CancelId.eventListener)
            case .refetch:
                return .concatenate(
                    .cancel(id: CancelId.loadMore),
                    .cancel(id: CancelId.fetch),
                    .run{ [state] send in
                        do{
                            let channels = try await service.channelListService.requestChannels(page: 0, perPage: (state.channelPage + 1) * 20)
                            await send(.updateChannels(channels))
                        }catch{
                            print(error)
                            await send(.error(error))
                        }
                    }.cancellable(id: CancelId.fetch)
                )
            case .loadAll:
                return .concatenate(
                    .cancel(id: CancelId.loadMore),
                    .cancel(id: CancelId.fetch),
                    .run{ send in
                        do{
                            let channels = try await service.channelListService.requestChannels(page: 0, perPage: 20)
                            _ = await [send(.updateChannelPage(0)), send(.updateChannels(channels))]
                        }catch{
                            print(error)
                            await send(.error(error))
                        }
                    }.cancellable(id: CancelId.fetch)
                )
            case .scrolledToBottom:
                return .concatenate(
                    .cancel(id: CancelId.loadMore),
                    .run{ [state] send in
                        do{
                            let channelPage = state.channelPage + 1
                            let channels = try await service.channelListService.requestChannels(page: channelPage, perPage: 20)
                            _ = await [send(.updateChannelPage(channelPage)), send(.insertChannels(channels))]
                        }catch{
                            print(error)
                            await send(.error(error))
                        }
                    }.cancellable(id: CancelId.loadMore)
                )
            case let .updateChannelPage(page):
                state.channelPage = page
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
            case let .insertChannels(channels):
                let newChannels = state.channels + channels
                return .send(.updateChannels(newChannels))
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
        case fetch
        case loadMore
    }
}
