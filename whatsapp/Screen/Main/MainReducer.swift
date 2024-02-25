//
//  MainReducer.swift
//  whatsapp
//
//  Created by 김수아 on 2/4/24.
//

import Foundation
import ComposableArchitecture
import WANetworkAPI
import Combine

@Reducer
struct MainReducer{
    @ObservableState
    enum State{
        case loggedIn(HomeReducer.State)
        case loggedOut(LoginReducer.State)
    }
    
    enum Action{
        case appear
        case updateState(State)
        
        case loggedIn(HomeReducer.Action)
        case loggedOut(LoginReducer.Action)
    }
    
    var body: some Reducer<State, Action>{
        Scope(state: \.loggedIn, action: \.loggedIn){
            HomeReducer()
        }
        Scope(state: \.loggedOut, action: \.loggedOut){
            LoginReducer()
        }
        Reduce{ state, action in
            switch action{
            case .appear:
                switch NetworkAPI.User.isLoggedIn{
                case true:
                    state = .loggedIn(.init())
                case false:
                    state = .loggedOut(.init())
                }
                return .run{ send in
                    for await isLoggedIn in isLoggedIn(){
                        switch isLoggedIn{
                        case true:
                            await send(.updateState(.loggedIn(.init())))
                        case false:
                            await send(.updateState(.loggedOut(.init())))
                        }
                    }
                }
            case let .updateState(newState):
                state = newState
            default:
                break
            }
            return .none
        }
    }
    
    private func isLoggedIn() -> AsyncStream<Bool>{
        AsyncStream{ continuation in
            let cancellable = Authorization.isLoggedIn.sink { _ in
                continuation.finish()
            } receiveValue: { (isLoggedIn: Bool) in
                continuation.yield(with: .success(isLoggedIn))
            }
            
            continuation.onTermination = { _ in
                cancellable.cancel()
            }
        }
    }
}
