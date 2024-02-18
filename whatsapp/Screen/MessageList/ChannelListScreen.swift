//
//  ChannelListScreen.swift
//  whatsapp
//
//  Created by 김수아 on 1/13/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import WANetworkAPI
import Algorithms

struct ChannelListScreen: View{
    // MARK: - Private
    @Environment(\.store)
    private var store: StoreEnvironment
    
    // MARK: - Internal
    var didTapCamera: (() -> Void)? = nil
    
    var body: some View{
        NavigationStack{
            WithViewStore(store.channelList, observe: { $0.channels }){ viewStore in
                List(viewStore.state.indexed(), id: \.1.id){ index, channel in
                    // FIXME: listRowSeparator에 inset을 주는 옵션을 찾지 못함. 이게 왜 없음..?
                    ZStack{
                        NavigationLink {
                            MessageDetailScreen(channel: channel)
                        } label: {
                            EmptyView()
                        }.opacity(0)
                        MessageListItem(channel: channel)
                    }.onAppear {
                        guard max(0, viewStore.state.count - 5) > index else{ return }
                        store.channelList.send(.scrolledToBottom)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Message")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Button(action: {
                            NetworkAPI.User.logout()
                            didTapCamera?()
                        }, label: {
                            Image(.Icon.camera).tint(Color.grayB2)
                        })
                    }
                }
            }
        }.onAppear(perform: {
            store.channelList.send(.attachEventListener)
        })
        .onDisappear(perform: {
            store.channelList.send(.detachEventListener)
        })
        .task{
            store.channelList.send(.loadAll)
        }
    }
}

#Preview{
    ChannelListScreen()
        .environment(\.store, StoreEnvironment())
}
