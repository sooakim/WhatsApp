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
        HStack{
            Spacer().frame(width: .infinity)
            ZStack{
                // FIXME: RoundedRectangle과 Text의 사이즈가 같아야함
                RoundedRectangle(cornerRadius: Metrics.dateRadius, style: .continuous)
                    .fill(Color.grayf2)
                Text(styleable: "Today".lineHeight(17.61))
                    .font(.custom(.regular, size: 14))
                    .foregroundStyle(Color.black100)
                    .padding(EdgeInsets(vertical: 6, horizontal: 24))
            }
            Spacer().frame(width: .infinity)
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
