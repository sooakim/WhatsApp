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
    struct State{
        var isLoggedIn: Bool = false
    }
    
    enum Action{
        case appear
        case login
        case logout
    }
    
    var body: some Reducer<State, Action>{
        Reduce{ state, action in
            switch action{
            case .appear:
                return .run{ send in
                    for await isLoggedIn in isLoggedIn(){
                        switch isLoggedIn{
                        case true:
                            await send(.login)
                        case false:
                            await send(.logout)
                        }
                    }
                }
            case .login:
                state.isLoggedIn = true
            case .logout:
                state.isLoggedIn = false
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
