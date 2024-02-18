//
//  JSONEncoder.swift
//
//
//  Created by 김수아 on 1/21/24.
//

import Foundation

extension JSONEncoder{
    static let shared = {
        let instance = JSONEncoder()
//        instance.keyEncodingStrategy = .convertToSnakeCase
        return instance
    }()
}

extension JSONEncoder{
    func encode<V: Encodable>(_ value: V) -> [String: Any]{
        do{
            let jsonData: Data = try Self.shared.encode(value)
            return try JSONSerialization.jsonObject(with: jsonData) as! [String: Any]
        }catch{
            return [:]
        }
    }
}
