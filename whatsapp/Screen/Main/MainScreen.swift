//
//  MainScreen.swift
//  whatsapp
//
//  Created by 김수아 on 1/14/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import WANetworkAPI

struct MainScreen: View{
    @Environment(\.store)
    var store: StoreEnvironment
    
    // MARK: - Internal
    
    var body: some View{
        switch store.main.state{
        case .loggedIn:
            if let store = store.main.scope(state: \.loggedIn, action: \.loggedIn){
                HomeScreen(store: store)
                    .task{
                        self.store.main.send(.appear)
                    }
            }
        case .loggedOut:
            if let store = store.main.scope(state: \.loggedOut, action: \.loggedOut){
                LoginScreen(store: store)
                    .task{
                        self.store.main.send(.appear)
                    }
            }
        }
    }
}

#Preview{
    MainScreen()
        .environment(\.store, StoreEnvironment())
}
