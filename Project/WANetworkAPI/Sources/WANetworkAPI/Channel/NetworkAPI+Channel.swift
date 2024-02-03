//
//  File.swift
//
//
//  Created by 김수아 on 1/21/24.
//

import Foundation
import Moya

public extension NetworkAPI{
    enum Channel: TargetType, Providable{
        case getAll(GetAll.Request)
        
        public var baseURL: URL {
            URL(string: "http://118.67.134.127:8065/")!
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
                do{
                    let jsonData = try JSONEncoder.shared.encode(requestBody)
                    let parameters = try JSONSerialization.jsonObject(with: jsonData) as! [String: Any]
                    return .requestParameters(parameters: parameters, encoding: URLEncoding())
                }catch{
                    return .requestPlain
                }
            }
        }
        
        public var headers: [String : String]? {
            nil
        }
    }
}
