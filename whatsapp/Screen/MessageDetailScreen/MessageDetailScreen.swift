//
//  MessageDetailScreen.swift
//  whatsapp
//
//  Created by 김수아 on 1/14/24.
//

import Foundation
import SwiftUI

enum ItemType{
    case date
    case messageFromUser(Message)
    case messageFromOther(Message)
}

struct MessageDetailScreen: View{
    var message: Message
    
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
                                itemType = .messageFromUser(message)
                            }else{
                                itemType = .messageFromOther(message)
                            }
                            return itemType
                        }()){
                        case .date:
                            MessageDateItem()
                        case let .messageFromOther(message):
                            MessageFromOtherItem()
                        case let .messageFromUser(message):
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
        .navigationTitle(message.senderName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                AsyncImage(url: message.senderProfileURL) { image in
                    image.resizable()
                        .clipShape(Circle())
                        .overlay(alignment: .bottomTrailing) {
                            if message.isActiveUser {
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: Metrics.activeCircleSize, height: Metrics.activeCircleSize)
                                    .overlay{
                                        Circle()
                                            .stroke(Color.white, lineWidth: 2)
                                            .frame(width: Metrics.activeCircleSize, height: Metrics.activeCircleSize)
                                    }
                            }
                        }
                } placeholder: {
                    Circle().fill(Color.key)
                }.frame(width: Metrics.profileSize, height: Metrics.profileSize)
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
            .frame(height: 33)
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
        MessageDetailScreen(
            message: Message(
                isActiveUser: true,
                senderProfileURL: URL(string: "https://placekitten.com/100/100"),
                senderName: "Kaiya Rhiel Madsen",
                lastMessage: "I need a link to the project",
                lastMessageSentAt: Date(),
                unreadMessageCount: 2
            )
        )
    }
}
