//
//  PostInChannel.swift
//  whatsapp
//
//  Created by 김수아 on 2/25/24.
//

import Foundation

struct PostInChannel: Equatable, Identifiable{
    let id: String
    let updatedAt: Date
    let deleteAt: Date?
    let senderId: String
    let message: String
}
