//
//  RoundedCorner.swift
//  whatsapp
//
//  Created by 김수아 on 1/14/24.
//

import Foundation
import SwiftUI

struct RoundedCorner: Shape{
    let cornerRadii: RectangleCornerRadii
    
    func path(in rect: CGRect) -> Path {
        Path(roundedRect: rect, cornerRadii: cornerRadii, style: .continuous)
    }
}
