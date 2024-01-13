//
//  Font+Font+NanumGothic.swift
//  whatsapp
//
//  Created by 김수아 on 1/13/24.
//

import Foundation
import SwiftUI

extension Font{
    enum NanumGothic{
        case light          //300
        case regular        //400
        case bold           //700
        case extraBold      //800
        
        fileprivate var fontName: String{
            switch self{
            case .light:
                return "나눔고딕OTF Light"
            case .regular:
                return "나눔고딕OTF"
            case .bold:
                return "나눔고딕OTF Bold"
            case .extraBold:
                return "나눔고딕OTF ExtraBold"
            }
        }
    }
    
    static func custom(_ name: NanumGothic, size: CGFloat) -> Font{
        Font.custom(name.fontName, size: size)                  //to support dynamic type
    }
}
