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
            ChannelListScreen()
                .tabItem {
                    Image(.Icon.tabStatus)
                }
            
            ChannelListScreen()
                .tabItem {
                    Image(.Icon.tabCall)
                }
            
            ChannelListScreen()
                .tabItem {
                    Image(.Icon.tabChat)
                }
            
            ChannelListScreen()
                .tabItem {
                    Image(.Icon.tabSetting)
                }
        }
    }
}

#Preview{
    HomeScreen()
}
