//
//  ChannelDetailItem.swift
//  whatsapp
//
//  Created by 김수아 on 2/25/24.
//

import Foundation

enum ChannelDetailItem: Equatable, Identifiable{
    case date(String)
    case postFromUser(PostInChannel)
    case postFromOther(PostInChannel)
    
    var id: String{
        switch self{
        case let .date(date):
            "date-\(date)"
        case let .postFromUser(post):
            "postFromUser-\(post.id)"
        case let .postFromOther(post):
            "postFromOther-\(post.id)"
        }
    }
}
