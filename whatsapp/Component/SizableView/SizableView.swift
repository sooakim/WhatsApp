//
//  SizableView.swift
//  whatsapp
//
//  Created by 김수아 on 1/14/24.
//

import Foundation
import SwiftUI

struct SizableView: View{
    var body: some View{
        GeometryReader{ geometry in
            Color.clear
                .preference(key: Key.self, value: geometry.size)
        }
    }
}

extension SizableView{
    struct Key: PreferenceKey{
        static var defaultValue: CGSize = .zero
        
        static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
            value = nextValue()
        }
    }
}
