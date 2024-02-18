//
//  File.swift
//  
//
//  Created by 김수아 on 2/11/24.
//

import Foundation

enum WebSocketAction: String, Encodable {
    case authenticationChallenge = "authentication_challenge"
    case userTyping = "user_typing"
    case getStatuses = "get_statuses"
    case getStatusesByIds = "get_statuses_by_ids"
}
