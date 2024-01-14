//
//  HomeScreen.swift
//  whatsapp
//
//  Created by 김수아 on 1/13/24.
//

import Foundation
import SwiftUI

struct HomeScreen: View{
    var body: some View{
        TabView{
            MessageListScreen()
                .tabItem {
                    Image(.Icon.tabStatus)
                }
            
            MessageListScreen()
                .tabItem {
                    Image(.Icon.tabCall)
                }
            
            MessageListScreen(messages: [
                Message(
                    isActiveUser: true,
                    senderProfileURL: URL(string: "https://placekitten.com/100/100"),
                    senderName: "Kaiya Rhiel Madsen",
                    lastMessage: "I need a link to the project",
                    lastMessageSentAt: Date(),
                    unreadMessageCount: 2
                ),
                Message(
                    isActiveUser: false,
                    senderProfileURL: URL(string: "https://placekitten.com/100/100"),
                    senderName: "Kaiya Rhiel Madsen",
                    lastMessage: "I need a link to the project",
                    lastMessageSentAt: Date(),
                    unreadMessageCount: 0
                )
            ]).tabItem {
                Image(.Icon.tabChat)
            }
            
            MessageListScreen()
                .tabItem {
                    Image(.Icon.tabSetting)
                }
        }
    }
}

#Preview{
    HomeScreen()
}
