//
//  UserLoginReducer.swift
//  whatsapp
//
//  Created by 김수아 on 2/4/24.
//

import Foundation
import ComposableArchitecture
import WANetworkAPI

@Reducer
struct UserLoginReducer{
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
                    let request = NetworkAPI.User.Login.Request(loginId: state.email, password: state.password)
                    do{
                        let responses: [NetworkAPI.User.Login.Response] = try await NetworkAPI.User.request(.login(request))
                        return
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
