//
//  File.swift
//
//
//  Created by 김수아 on 2/18/24.
//

import Foundation

public protocol WebSocketProvidable{
    associatedtype Request: Encodable
    associatedtype Response: Decodable
    associatedtype Error: Swift.Error
    
    static func request(_ request: Request) async throws -> Response
}

private var sequenceNumberKey: Void?

extension WebSocketProvidable{
    static var sequence: Int{
        get {
            let sequence = objc_getAssociatedObject(self, &sequenceNumberKey) as? Int ?? 1
            defer{ objc_setAssociatedObject(self, &sequenceNumberKey, sequence + 1, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
            return sequence
        }
    }
}
