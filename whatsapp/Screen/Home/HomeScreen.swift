//
//  HomeScreen.swift
//  whatsapp
//
//  Created by 김수아 on 1/13/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct HomeScreen: View{
    let store: StoreOf<HomeReducer>
    
    var body: some View{
        TabView{
            ChannelListScreen(store: store.scope(state: \.tab1, action: \.tab1))
                .tabItem {
                    Image(.Icon.tabStatus)
                }
            
            ChannelListScreen(store: store.scope(state: \.tab2, action: \.tab2))
                .tabItem {
                    Image(.Icon.tabCall)
                }
            
            ChannelListScreen(store: store.scope(state: \.tab3, action: \.tab3))
                .tabItem {
                    Image(.Icon.tabChat)
                }
            
            ChannelListScreen(store: store.scope(state: \.tab4, action: \.tab4))
                .tabItem {
                    Image(.Icon.tabSetting)
                }
        }
    }
}

#Preview{
    HomeScreen(store: StoreEnvironment().home)
}
