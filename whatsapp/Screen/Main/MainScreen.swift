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
        WithViewStore(store.main, observe: { $0.isLoggedIn }){ viewStore in
            if viewStore.state{
                HomeScreen()
            }else{
                LoginScreen()
            }
        }.task {
            store.main.send(.appear)
        }
    }
}

#Preview{
    MainScreen()
}
