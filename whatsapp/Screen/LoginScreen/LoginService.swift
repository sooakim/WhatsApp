//
//  LoginRepository.swift
//  whatsapp
//
//  Created by 김수아 on 2/4/24.
//

import Foundation
import WANetworkAPI

protocol LoginServiceable {
    func requestLogin(email: String, password: String) async throws
}

struct LoginService: LoginServiceable{
    
    func requestLogin(email: String, password: String) async throws {
        let request = NetworkAPI.User.Login.Request(loginId: email, password: password)
        let _: [NetworkAPI.User.Login.Response] = try await NetworkAPI.User.request(.login(request))
    }
}
