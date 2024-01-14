//
//  MessageFromOtherItem.swift
//  whatsapp
//
//  Created by 김수아 on 1/14/24.
//

import Foundation
import SwiftUI

struct MessageFromOtherItem: View{
    @State private var messageSize: CGSize = .zero
    
    var body: some View{
        let messageBody = {
            Text(styleable: """
            I plan to go to Norway
            """.lineHeight(17.05))
            .font(.custom(.regular, size: 14))
            .foregroundStyle(Color.black100)
        }
        let infoBody = {
            HStack(spacing: 5){
                Text(styleable: "12:51".lineHeight(13.18))
                    .font(.custom(.light, size: 10))
                    .foregroundStyle(Color.grayBE)
            }
        }
        
        ZStack{
            if messageSize.width >= 275{
                VStack(alignment: .trailing, spacing: 4){
                    messageBody()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
                    
                    infoBody()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 11))
                }
                .padding(EdgeInsets(top: 11, leading: 15, bottom: 6, trailing: 0))
                .background(Color.grayf2)
                .clipShape(RoundedCorner(cornerRadii: RectangleCornerRadii(topLeading: Metrics.messageRadius, bottomLeading: 0, bottomTrailing: Metrics.messageRadius, topTrailing: Metrics.messageRadius)))
                .frame(maxWidth: 275)
                .overlay(SizableView())
                
            }else{
                HStack(alignment: .bottom, spacing: 12){
                    messageBody()
                    infoBody()
                }
                .padding(EdgeInsets(top: 11, leading: 15, bottom: 6, trailing: 11))
                .background(Color.grayf2)
                .clipShape(RoundedRectangle(cornerRadius: Metrics.messageRadius, style: .continuous))
                .overlay(SizableView())
            }
        }
        .padding(EdgeInsets(vertical: 4, horizontal: 16))
        .frame(maxWidth: .infinity, alignment: .leading)
        .onPreferenceChange(SizableView.Key.self, perform: { size in
            messageSize = size
            print(messageSize)
        })
    }
}

private extension MessageFromOtherItem{
    enum Metrics{
        static let messageRadius: CGFloat = 10
    }
}

#Preview{
    MessageFromOtherItem()
}
