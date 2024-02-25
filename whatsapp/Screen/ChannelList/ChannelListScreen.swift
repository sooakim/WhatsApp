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
    @Perception.Bindable var store: StoreOf<ChannelListReducer>
    
    // MARK: - Internal
    var didTapCamera: (() -> Void)? = nil
    
    var body: some View{
        NavigationStack(
            path: $store.scope(state: \.path, action: \.path)
        ){
            List{
                ForEachStore(store.scope(state: \.channelDetails, action: \.channelDetails)) { store in
                    ZStack{
                        NavigationLink {
                            ChannelDetailScreen(store: store)
                        } label: {
                            EmptyView()
                        }.opacity(0)
                        ChannelListItem(channel: store.state.channel)
                    }
                    //                    .onAppear {
                    //                        guard max(0, viewStore.state.count - 5) > index else{ return }
                    //                        store.send(.scrolledToBottom)
                    //                    }
                    .listStyle(.plain)
                }
            }
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
            .onAppear(perform: {
                store.send(.attachEventListener)
            })
            .onDisappear(perform: {
                store.send(.detachEventListener)
            })
            .task{
                store.send(.loadAll)
            }
            .alert(store: store.scope(state: \.$alert, action: \.alert))
        } destination: { store in
            switch store.state{
            case .detail:
                if let store = store.scope(state: \.detail, action: \.detail){
                    ChannelDetailScreen(store: store)
                }
            }
        }
    }
}

#Preview{
    ChannelListScreen(store: StoreEnvironment().channelList)
}
