//
//  LoginReducer.swift
//  whatsapp
//
//  Created by 김수아 on 2/4/24.
//

import Foundation
import ComposableArchitecture
import WANetworkAPI

@Reducer
struct LoginReducer{
    @Dependency(\.service) var service
    
    @ObservableState
    struct State{
        var email: String = ""
        var password: String = ""
    }
    
    enum Action{
        case login
        case updateEmail(String)
        case updatePassword(String)
        case error(Error)
    }
    
    var body: some Reducer<State, Action> {
        Reduce{ state, action in
            switch action{
            case .login:
                return .run{ [state] send in
                    do{
                        try await service.loginService.requestLogin(email: state.email, password: state.password)
                    }catch{
                        return await send(.error(error))
                    }
                }
            case let .updateEmail(email):
                state.email = email
            case let .updatePassword(password):
                state.password = password
            case .error:
                break
            }
            return .none
        }
    }
}
