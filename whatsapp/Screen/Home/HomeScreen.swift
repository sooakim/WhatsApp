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
            
            MessageListScreen()
                .tabItem {
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
