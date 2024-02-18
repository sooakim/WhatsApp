//
//  File.swift
//
//
//  Created by 김수아 on 1/21/24.
//

import Foundation
import Moya

extension NetworkAPI{
    public enum Channel: TargetType, Providable{
        case getAll(GetAll.Request)
        
        public var baseURL: URL {
            ServerEnvironment.baseHttpURL
        }
        
        public var path: String {
            var path = "api/v4/channels"
            switch self{
            case .getAll:
                break
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
            case let .getAll(requestBody):
                return .requestParameters(parameters: JSONEncoder.shared.encode(requestBody), encoding: URLEncoding())
            }
        }
        
        public var headers: [String : String]? {
            nil
        }
    }
}
