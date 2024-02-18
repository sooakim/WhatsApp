//
//  File.swift
//  
//
//  Created by 김수아 on 2/18/24.
//

import Foundation

struct WebSocketRequest<Data: Encodable>: Encodable{
    let seq: Int
    let action: WebSocketAction
    let data: Data
}
