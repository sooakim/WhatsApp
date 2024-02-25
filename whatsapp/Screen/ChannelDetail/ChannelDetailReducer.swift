//
//  ChannelDetailReducer.swift
//  whatsapp
//
//  Created by 김수아 on 2/25/24.
//

import Foundation
import ComposableArchitecture
import WANetworkAPI
import Combine

@Reducer
struct ChannelDetailReducer{
    @Dependency(\.service) var service
    
    @ObservableState
    struct State: Equatable, Identifiable{
        let channel: Channel
        var prevPostId: String?
        var posts: [PostInChannel] = []
        var items: [ChannelDetailItem] = []
        
        @Presents
        var alert: AlertState<Action.Alert>?
        
        var id: String{
            channel.id
        }
    }
    
    enum Action{
        // MARK: - Public Action
        case attachEventListener
        case detachEventListener
        case loadAll
        case scrolledToTop
        case alert(PresentationAction<Alert>)
        
        // MARK: - Internal Action
        case updatePosts([PostInChannel], prevPostId: String?)
        case insertPosts([PostInChannel], prevPostId: String?)
        case error(Error)
        
        enum Alert: Equatable {
            
        }
    }
    
    var body: some Reducer<State, Action> {
        Reduce{ state, action in
            switch action{
            case .attachEventListener:
                // TODO: implement later
                return .none
            case .detachEventListener:
                return .cancel(id: CancelId.eventListener)
            case .loadAll:
                return .concatenate(
                    .cancel(id: CancelId.loadMore),
                    .cancel(id: CancelId.fetch),
                    .run{ [state] send in
                        do{
                            let (posts, prevPostId) = try await service.channelDetailService.requestPosts(channelId: state.channel.id, beforeId: nil)
                            await send(.updatePosts(posts, prevPostId: prevPostId))
                        }catch{
                            print(error)
                            await send(.error(error))
                        }
                    }.cancellable(id: CancelId.fetch)
                )
            case .scrolledToTop:
                return .concatenate(
                    .cancel(id: CancelId.loadMore),
                    .run{ [state] send in
                        do{
                            let (posts, prevPostId) = try await service.channelDetailService.requestPosts(channelId: state.channel.id, beforeId: state.prevPostId)
                            await send(.insertPosts(posts, prevPostId: prevPostId))
                        }catch{
                            print(error)
                            await send(.error(error))
                        }
                    }.cancellable(id: CancelId.loadMore)
                )
            case let .updatePosts(posts, prevPostId):
                state.posts = posts
                state.prevPostId = prevPostId
                
                state.items = state.posts.map{ 
                    if NetworkAPI.User
                    .postFromUser($0)
                }
            case let .insertPosts(posts, prevPostId):
                state.posts += posts
                state.prevPostId = prevPostId
                
                state.items = state.posts.map{
                    .postFromUser($0)
                }
            case let .error(error):
                if let error = error as? WANetworkError, case let .response(message, _, _, _, _) = error{
                    state.alert = AlertState{
                        TextState(message)
                    }
                }
            case .alert:
                state.alert = nil
            }
            return .none
        }.ifLet(\.$alert, action: \.alert)
    }
    
    private enum CancelId{
        case eventListener
        case fetch
        case loadMore
    }
}

