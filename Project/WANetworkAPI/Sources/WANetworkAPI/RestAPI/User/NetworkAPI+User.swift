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
        case getAll(GetAll.Request)
        case getStatus(GetStatus.Request)
        case getUnreadMessages(GetUnreadMessages.Request)
        
        
        public var baseURL: URL {
            ServerEnvironment.baseHttpURL
        }
        
        public var path: String {
            var path = "api/v4/users"
            switch self{
            case .login:
                path += "/login"
            case .getAll:
                break
            case let .getStatus(requestBody):
                path += "/\(requestBody.userId)/status"
            case let .getUnreadMessages(requestBody):
                path += "/\(requestBody.userId)/channels/\(requestBody.channel_id)/unread"
            }
            return path
        }
        
        public var method: Moya.Method {
            switch self{
            case .login:
                return .post
            case .getAll, .getStatus, .getUnreadMessages:
                return .get
            }
        }
        
        public var task: Moya.Task {
            switch self{
            case let .login(requestBody):
                return .requestJSONEncodable(requestBody)
            case let .getAll(requestBody):
                return .requestParameters(parameters: JSONEncoder.shared.encode(requestBody), encoding: URLEncoding())
            case .getStatus, .getUnreadMessages:
                return .requestPlain
            }
        }
        
        public var headers: [String : String]? {
            nil
        }
    }
}

public extension NetworkAPI.User{
    static var isLoggedIn: Bool{
        Keychain["token"] != nil
    }
    
    static var token: String?{
        Keychain["token"]
    }
    
    static func logout(){
        Keychain["token"] = nil
        UserDefault.user = nil
        Authorization._isLoggedIn.send(false)
    }
}
