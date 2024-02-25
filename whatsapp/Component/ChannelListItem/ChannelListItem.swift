//
//  ChannelListItem.swift
//  whatsapp
//
//  Created by 김수아 on 1/12/24.
//

import Foundation
import SwiftUI
import Kingfisher

struct ChannelListItem: View{
    var channel: Channel
    
    var body: some View{
        HStack(spacing: 14){
            if channel.isActiveUser {
                KFImage.url(channel.senderProfileURL)
                    .placeholder{
                        Circle().fill(Color.key)
                    }
                    .onFailure({ error in
                        print(error)
                    })
                    .resizable()
                    .clipShape(Circle()).padding(3)
                    .overlay{
                        Circle().stroke(Color.green, lineWidth: 3)
                    }
                    .frame(width: Metrics.profileSize, height: Metrics.profileSize)
            }else{
                KFImage.url(channel.senderProfileURL)
                    .placeholder{
                        Circle().fill(Color.key)
                    }
                    .onFailure({ error in
                        print(error)
                    })
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: Metrics.profileSize, height: Metrics.profileSize)
            }
            
            VStack(alignment: .leading, spacing: 0){
                Text(styleable: channel.senderName.lineHeight(24))
                    .font(.custom(.bold, size: 16))
                    .foregroundStyle(Color.black100)
                Text(styleable: channel.lastMessage.lineHeight(16.41))
                    .font(.custom(.regular, size: 14))
                    .foregroundStyle(Color.black100)
            }.frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .trailing, spacing: 0){
                Text(styleable: channel.lastMessageSentAt.asRelativeDateTime().lineHeight(16.41))
                    .font(.custom(.regular, size: 14))
                    .foregroundStyle(Color.black100)
                
                if channel.unreadMessageCount > 0{
                    UnreadMessageBubble(count: channel.unreadMessageCount)
                }else{
                    Spacer().frame(height: 14.5)
                    Image(.Icon.messageRead)
                        .foregroundStyle(Color.skyBlue)
                }
            }
        }.padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 16))
    }
}



private extension ChannelListItem{
    enum Metrics{
        static let profileSize: CGFloat = 55
    }
}

#Preview{
    List(0..<100){ index in
        if index % 2 == 0{
            ChannelListItem(
                channel: Channel(
                    id: "",
                    isActiveUser: true,
                    senderId: "bmxkuy8r1bri5xwx64xhs1o8tw",
                    senderProfileURL: URL(string: "https://placekitten.com/100/100"),
                    senderName: "Kaiya Rhiel Madsen",
                    lastMessage: "I need a link to the project",
                    lastMessageSentAt: Date(),
                    unreadMessageCount: 2
                )
            )
        }else{
            ChannelListItem(
                channel: Channel(
                    id: "",
                    isActiveUser: false,
                    senderId: "bmxkuy8r1bri5xwx64xhs1o8tw",
                    senderProfileURL: URL(string: "https://placekitten.com/100/100"),
                    senderName: "Kaiya Rhiel Madsen",
                    lastMessage: "I need a link to the project",
                    lastMessageSentAt: Date(),
                    unreadMessageCount: 0
                )
            )
        }
    }
}
