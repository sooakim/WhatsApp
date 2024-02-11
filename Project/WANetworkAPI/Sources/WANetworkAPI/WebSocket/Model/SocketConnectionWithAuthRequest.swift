//
//  File.swift
//  
//
//  Created by 김수아 on 2/11/24.
//

import Foundation
import MetaCodable

@Codable
struct SocketConnectionWithAuthRequest{
    let seq: Int
    let action: String
    let data: Data
    
    @Codable
    struct Data: Encodable{
        let token: String
    }
}
