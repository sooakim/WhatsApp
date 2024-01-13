//
//  MessageListScreen.swift
//  whatsapp
//
//  Created by 김수아 on 1/13/24.
//

import Foundation
import SwiftUI

struct MessageListScreen: View{
    // MARK: - Private
    @State private var messages: [Message]
    
    // MARK: - Internal
    var didTapCamera: (() -> Void)? = nil
    
    init(messages: [Message] = []){
        self._messages = State.init(wrappedValue: messages)
    }
    
    var body: some View{
        NavigationStack{
            List{
                ForEach(messages) { message in
                    // FIXME: listRowSeparator에 inset을 주는 옵션을 찾지 못함. 이게 왜 없음..?
                    MessageListItem(message: message)
                        .listRowSeparator(.visible, edges: .bottom)
                        .listRowSeparatorTint(Color.grayE2)
                        .listRowInsets(.zero)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button(action: {
                        didTapCamera?()
                    }, label: {
                        Image(.Icon.camera).tint(Color.grayB2)
                    })
                }
            }
        }
    }
}

#Preview{
    MessageListScreen(
        messages: [
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
        ]
    )
}
