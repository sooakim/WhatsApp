//
//  MessageDetailScreen.swift
//  whatsapp
//
//  Created by 김수아 on 1/14/24.
//

import Foundation
import SwiftUI
import Kingfisher

enum ItemType{
    case date
    case messageFromUser(Channel)
    case messageFromOther(Channel)
}

struct MessageDetailScreen: View{
    var channel: Channel
    
    @State var messageInput: String = ""
    
    var body: some View{
        VStack{
            // FIXME: hmm.. 리스트를 반전시켜서 scrollToTop동작도 반전 시키고 싶음..
            ScrollViewReader{ scrollViewReader in
                List((0..<100)){ index in
                    ZStack{
                        switch ({ () -> ItemType in
                            let itemType: ItemType
                            if index % 3 == 0{
                                itemType = .date
                            }else if index % 3 == 1{
                                itemType = .messageFromUser(channel)
                            }else{
                                itemType = .messageFromOther(channel)
                            }
                            return itemType
                        }()){
                        case .date:
                            MessageDateItem()
                        case let .messageFromOther(channel):
                            MessageFromOtherItem()
                        case let .messageFromUser(channel):
                            MessageFromUserItem()
                        }
                    }
                    .scaleEffect(y: -1)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.zero)
                }
                .listStyle(.plain)
                .scaleEffect(y: -1)
                .scrollDismissesKeyboard(.interactively)
            }
            
            // FIXME: ToolbarItem(.keyboard){}로 넣고 싶었는데 SwiftUI에서 viewController를 어떻게 becomeFirstResponder로 만들어야할지 모르겠음
            InputAccessoryView(messageInput: $messageInput)
        }
        .navigationTitle(channel.senderName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                KFImage.url(channel.senderProfileURL)
                    .placeholder{
                        Circle().fill(Color.key)
                    }
                    .resizable()
                    .clipShape(Circle())
                    .overlay(alignment: .bottomTrailing) {
                        if channel.isActiveUser {
                            Circle()
                                .fill(Color.green)
                                .frame(width: Metrics.activeCircleSize, height: Metrics.activeCircleSize)
                                .overlay{
                                    Circle()
                                        .stroke(Color.white100, lineWidth: 2)
                                        .frame(width: Metrics.activeCircleSize, height: Metrics.activeCircleSize)
                                }
                        }
                    }
                    .frame(width: Metrics.profileSize, height: Metrics.profileSize)
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

private extension MessageDetailScreen{
    enum Metrics{
        static let profileSize: CGFloat = 40
        static let activeCircleSize: CGFloat = 12
    }
}

private struct InputAccessoryView: View{
    @Binding var messageInput: String
    
    var didTapAttachment: (() -> Void)?
    var didTapEmoji: (() -> Void)?
    var didTapMicrophone: (() -> Void)?
    
    var body: some View{
        HStack(alignment: .center, spacing: 9){
            Button(action: {
                didTapAttachment?()
            }, label: {
                Image(.Icon.attachment)
                    .foregroundStyle(Color.gray80)
            })
            HStack(alignment: .center, spacing: 6){
                TextField(text: $messageInput) {
                    Text("Message")
                }
                .lineLimit(nil)
                .font(.custom(.regular, size: 14))
                .foregroundStyle(Color.grayC5)
                
                Button(action: {
                    didTapEmoji?()
                }, label: {
                    Image(.Icon.emoji)
                        .foregroundStyle(Color.gray80)
                })
            }
            .padding(EdgeInsets(top: 6, leading: 13, bottom: 6, trailing: 6))
            .background(Color.grayf2)
            .clipShape(RoundedRectangle(cornerRadius: Metrics.messageInputRadius, style: .continuous))
            Button(action: {
                didTapMicrophone?()
            }, label: {
                Image(.Icon.microphone)
                    .foregroundStyle(Color.gray80)
            })
        }.padding(EdgeInsets(top: 15, leading: 16, bottom: 8, trailing: 16))
    }
}

private extension InputAccessoryView{
    enum Metrics{
        static let messageInputRadius: CGFloat = 40
    }
}

#Preview{
    NavigationStack{
        MessageDetailScreen(channel: Channel(
            id: "dng9iumsbfnk9d6wuhb5m4hoga",
            isActiveUser: true,
            senderId: "bmxkuy8r1bri5xwx64xhs1o8tw",
            senderProfileURL: URL(string: "ServerEnvironment.baseHttpURL.absoluteString/api/v4/users/bmxkuy8r1bri5xwx64xhs1o8tw/image"),
            senderName: "alice2863",
            lastMessage: "alice2863 joined the channel.",
            lastMessageSentAt: Date(iso8601: "2024-02-11'T'06:05:58'Z'0000") ?? Date(),
            unreadMessageCount: 0
        )).environment(\.store, StoreEnvironment())
    }
}
