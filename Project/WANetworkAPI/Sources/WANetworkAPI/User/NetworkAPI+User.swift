//
//  File.swift
//  
//
//  Created by 김수아 on 2/3/24.
//

import Foundation
import Moya

extension NetworkAPI{
    public enum User: TargetType, Providable{
        case login(Login.Request)
        
        public var baseURL: URL {
            URL(string: "http://118.67.134.127:8065/")!
        }
        
        public var path: String {
            var path = "api/v4/users"
            switch self{
            case .login:
                path += "/login"
            }
            return path
        }
        
        public var method: Moya.Method {
            switch self{
            case .login:
                return .post
            }
        }
        
        public var task: Moya.Task {
            switch self{
            case let .login(requestBody):
                return .requestJSONEncodable(requestBody)
            }
        }
        
        public var headers: [String : String]? {
            nil
        }
    }
}

public extension NetworkAPI.User{
    var isLoggedIn: Bool{
        Keychain["token"] != nil
    }
}
