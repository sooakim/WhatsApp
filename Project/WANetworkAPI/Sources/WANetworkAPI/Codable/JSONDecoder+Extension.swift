//
//  JSONDecoder.swift
//
//
//  Created by 김수아 on 1/21/24.
//

import Foundation

extension JSONDecoder{
    static let shared = {
        let instance = JSONDecoder()
//        instance.keyDecodingStrategy = .convertFromSnakeCase
        return instance
    }()
}

