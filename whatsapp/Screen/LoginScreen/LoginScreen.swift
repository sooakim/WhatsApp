//
//  LoginScreen.swift
//  whatsapp
//
//  Created by 김수아 on 2/4/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct LoginScreen: View{
    @Perception.Bindable var store: StoreOf<LoginReducer>
    
    var body: some View{
        WithPerceptionTracking{
            VStack(alignment: .leading, spacing: 12){
                TextField(text: $store.email.sending(\.updateEmail)) {
                    Text("Email or Username")
                }
                .padding(EdgeInsets(all: 12))
                .background{
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.grayE2, lineWidth: 1)
                }
                
                SecureField(text: $store.password.sending(\.updatePassword)) {
                    Text("Password")
                }
                .padding(EdgeInsets(all: 12))
                .background{
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.grayE2, lineWidth: 1)
                }
               
                Button(action: {}, label: {
                    Text("Forgot your password?")
                        .font(.custom(.regular, size: 12))
                })
                
                Button(action: {
                    store.send(.login)
                }, label: {
                    Text("Login")
                        .font(.custom(.regular, size: 24))
                        .foregroundStyle(Color.white100)
                })
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(all: 12))
                .background(Color.key)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(EdgeInsets(all: 24))
        }
    }
}

#Preview{
    LoginScreen(store: StoreEnvironment().login)
}
