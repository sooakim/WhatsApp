//
//  File.swift
//
//
//  Created by 김수아 on 2/4/24.
//

import Foundation
import Moya

extension NetworkAPI.Channel{
    public enum Member: TargetType, Providable{
        case getAll(channelId: String, GetAll.Request)
        
        public var baseURL: URL {
            ServerEnvironment.baseHttpURL
        }
        
        public var path: String {
            var path = "api/v4/channels/"
            switch self{
            case let .getAll(channelId, _):
                path += "\(channelId)/members"
            }
            return path
        }
        
        public var method: Moya.Method {
            switch self{
            case .getAll:
                return .get
            }
        }
        
        public var task: Moya.Task {
            switch self{
            case let .getAll(_, requestBody):
                return .requestParameters(parameters: JSONEncoder.shared.encode(requestBody), encoding: URLEncoding())
            }
        }
        
        public var headers: [String : String]? {
            nil
        }
    }
}
