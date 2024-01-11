//
//  MessageListItem.swift
//  whatsapp
//
//  Created by 김수아 on 1/12/24.
//

import Foundation
import SwiftUI

struct MessageListItem: View{
    var isActiveUser: Bool = true
    
    var body: some View{
        HStack(spacing: 14){
            AsyncImage(url: URL(string: "https://placekitten.com/200/300")!) { image in
                if isActiveUser {
                    image.resizable().clipShape(Circle()).padding(3)
                        .overlay{
                            Circle().stroke(Color.green, lineWidth: 3)
                        }
                }else{
                    image.resizable()
                }
            } placeholder: {
                Circle().fill(Color.grayf2)
            }.frame(width: Metrics.profileSize, height: Metrics.profileSize)

            VStack(alignment: .leading, spacing: 0){
                Text("Kaiya Rhiel Madsen")
                Text("I need a link to the project")
            }.frame(maxWidth: .infinity, alignment: .leading)
        }.padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 16))
    }
}

private extension MessageListItem{
    enum Metrics{
        static let profileSize: CGFloat = 55
    }
}

#Preview{
    List{
        ForEach(0..<100) { _ in
            MessageListItem()
        }
    }
}
