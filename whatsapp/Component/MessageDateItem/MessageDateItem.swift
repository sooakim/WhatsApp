//
//  MessageDateItem.swift
//  whatsapp
//
//  Created by 김수아 on 1/14/24.
//

import Foundation
import SwiftUI

struct MessageDateItem: View{
    var body: some View{
        VStack(alignment: .center){
            Text(styleable: "Today".lineHeight(17.61))
                .font(.custom(.regular, size: 14))
                .foregroundStyle(Color.black100)
                .padding(EdgeInsets(vertical: 6, horizontal: 24))
                .background(Color.grayf2)
                .clipShape(RoundedRectangle(cornerRadius: Metrics.dateRadius, style: .continuous))
        }.padding(EdgeInsets(vertical: 20))
    }
}

private extension MessageDateItem{
    enum Metrics{
        static let dateRadius: CGFloat = 40
    }
}

#Preview{
    MessageDateItem()
}
