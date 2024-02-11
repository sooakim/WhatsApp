//
//  WelcomeScreen.swift
//  whatsapp
//
//  Created by 김수아 on 1/13/24.
//

import Foundation
import SwiftUI

struct WelcomeScreen: View{
    // MARK: - Private
    @State private var smsCode: String = "123456"
    
    // MARK: - Internal
    var didTapDone: (() -> Void)?
    
    var body: some View{
        ZStack{
            Image(.bgWelcome)
            VStack(alignment: .center) {
                Image(.Icon.logoWelcome)
                Spacer().frame(height: 42)
                Text(styleable: "Welcome to WhatsApp".lineHeight(36))
                    .font(.custom(.regular, size: 24))
                Spacer().frame(height: 16)
                Text(styleable: "Enter SMS code".lineHeight(21))
                    .font(.custom(.regular, size: 14))
                Spacer().frame(height: 26)
                HStack(alignment: .firstTextBaseline){
                    ForEach(0..<3){ index in
                        TextField(text: .constant(String(smsCode[smsCode.index(smsCode.startIndex, offsetBy: index)]))) {
                            Text("_")
                        }
                        .disabled(smsCode.count < index)
                        .textFieldStyle(.plain)
                        .frame(width: 10, alignment: .center)
                    }
                
                    Spacer().frame(width: 16)
                    
                    ForEach(3..<6){ index in
                        TextField(text: .constant(String(smsCode[smsCode.index(smsCode.startIndex, offsetBy: index)]))) {
                            Text("_")
                        }
                        .disabled(smsCode.count < index)
                        .textFieldStyle(.plain)
                        .frame(width: 10, alignment: .center)
                    }
                }
                Spacer().frame(height: 51)
                Button(action: {
                    didTapDone?()
                }, label: {
                    Text("Done")
                        .foregroundStyle(Color.white100)
                })
                .padding(EdgeInsets(vertical: 12, horizontal: 90))
                .background(Color.key)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
        }
    }
}

#Preview{
    WelcomeScreen()
}
