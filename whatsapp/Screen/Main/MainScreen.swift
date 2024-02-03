//
//  MainScreen.swift
//  whatsapp
//
//  Created by 김수아 on 1/14/24.
//

import Foundation
import SwiftUI

struct MainScreen: View{
    // MARK: - Private
    @State private var isLoggedIn: Bool = true
    
    // MARK: - Internal
    
    var body: some View{
        if isLoggedIn{
            HomeScreen()
        }else{
            LoginScreen()
        }
    }
}

#Preview{
    MainScreen()
}

