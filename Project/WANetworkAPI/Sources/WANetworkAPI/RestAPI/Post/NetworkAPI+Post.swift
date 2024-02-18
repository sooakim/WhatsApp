//
//  File.swift
//
//
//  Created by 김수아 on 2/5/24.
//

import Foundation
import Moya

public extension NetworkAPI{
    enum Post: TargetType, Providable{
        case getForChannel(GetForChannel.Request)
        case createPost(CreatePost.Request)
        
        public var baseURL: URL{
            ServerEnvironment.baseHttpURL
        }
        
        public var path: String{
            switch self{
            case let .getForChannel(requestBody):
                return "api/v4/channels/\(requestBody.channelId)/posts"
            case let .createPost(requestBody):
                return "api/v4/posts"
            }
        }
        
        public var method: Moya.Method{
            switch self{
            case .getForChannel:
                return .get
            case .createPost:
                return .post
            }
        }
        
        public var task: Task{
            switch self{
            case let .getForChannel(requestBody):
                return .requestParameters(parameters: JSONEncoder.shared.encode(requestBody), encoding: URLEncoding())
            case let .createPost(requestBody):
                return .requestJSONEncodable(requestBody)
            }
        }
        
        public var headers: [String : String]?{
            nil
        }
    }
}
