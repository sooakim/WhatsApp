//
//  File.swift
//  
//
//  Created by 김수아 on 2/25/24.
//

import Foundation
import MetaCodable

extension NetworkAPI.Common{
    enum Error {}
}

extension NetworkAPI.Common.Error{
    @Codable
    @MemberInit
    public struct Response{
        @CodedAt("id")
        public let id: String
        @CodedAt("message")
        public let message: String
        @CodedAt("detailed_error")
        public let detailedError: String
        @CodedAt("request_id")
        public let requestId: String
        @CodedAt("status_code")
        public let statusCode: Int
    }
}
