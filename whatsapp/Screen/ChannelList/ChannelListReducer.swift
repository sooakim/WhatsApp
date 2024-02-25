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
    
    @ObservableState
    struct State{
        var channelPage: Int = 0
        var channelDetails: IdentifiedArrayOf<ChannelDetailReducer.State> = []
       
        // MARK: - Navigation
        @Presents
        var alert: AlertState<Action.Alert>?
        var path = StackState<Path.State>()
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
        
        // MARK: - Navigation
        case path(StackAction<Path.State, Path.Action>)
        case channelDetails(IdentifiedActionOf<ChannelDetailReducer>)
        case alert(PresentationAction<Alert>)
        
        enum Alert: Equatable {
          
        }
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
                state.channelDetails = IdentifiedArray(uniqueElements: channels.map{ ChannelDetailReducer.State(channel: $0) })
            case let .insertChannels(channels):
                state.channelDetails += IdentifiedArray(uniqueElements: channels.map{ ChannelDetailReducer.State(channel: $0) })
            case let .updateSenderStatus(isActiveUser, userId):
                state.channelDetails = IdentifiedArray(uniqueElements: state.channelDetails.map { channelDetail in
                    guard channelDetail.channel.senderId == userId else{ return channelDetail }
                    var newChannel = channelDetail.channel
                    newChannel.isActiveUser = isActiveUser
                    return ChannelDetailReducer.State(channel: newChannel)
                })
            case let .error(error):
                if let error = error as? WANetworkError, case let .response(message, _, _, _, _) = error{
                    state.alert = AlertState{
                        TextState(message)
                    }
                }
            case .alert:
                state.alert = nil
            case .channelDetails:
                break
            case .path:
                break
            }
            return .none
        }
        .ifLet(\.$alert, action: \.alert)
        .forEach(\.path, action: \.path){
            Path()
        }
        .forEach(\.channelDetails, action: \.channelDetails){
            ChannelDetailReducer()
        }
    }
    
    private enum CancelId{
        case eventListener
        case fetch
        case loadMore
    }
    
    @Reducer
    struct Path{
        @ObservableState
        enum State{
            case detail(ChannelDetailReducer.State)
        }
        
        enum Action{
            case detail(ChannelDetailReducer.Action)
        }
        
        var body: some Reducer<State, Action>{
            Scope(state: \.detail, action: \.detail){
                ChannelDetailReducer()
            }
        }
    }
}
