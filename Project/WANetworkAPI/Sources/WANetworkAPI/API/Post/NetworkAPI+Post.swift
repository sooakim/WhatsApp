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
        
        public var baseURL: URL{
            URL(string: "http://118.67.134.127:8065/")!
        }
        
        public var path: String{
            switch self{
            case let .getForChannel(requestBody):
                return "api/v4/channels/\(requestBody.channelId)/posts"
            }
        }
        
        public var method: Moya.Method{
            switch self{
            case .getForChannel:
                return .get
            }
        }
        
        public var task: Task{
            switch self{
            case let .getForChannel(requestBody):
                return .requestParameters(parameters: JSONEncoder.shared.encode(requestBody), encoding: URLEncoding())
            }
        }
        
        public var headers: [String : String]?{
            nil
        }
    }
}
