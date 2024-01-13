//
//  StringStyleable.swift
//  whatsapp
//
//  Created by 김수아 on 1/14/24.
//

import Foundation
import SwiftUI
import UIKit

protocol StringStylable{
    func lineHeight(_ lineHeight: CGFloat) -> StringStylable
    
    func asAttributedString() -> AttributedString
}

extension String: StringStylable{
    func lineHeight(_ lineHeight: CGFloat) -> StringStylable {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        
        var container = AttributeContainer()
        container.paragraphStyle = paragraphStyle
        return AttributedString(self, attributes: container)
    }
    
    func asAttributedString() -> AttributedString {
        AttributedString(self)
    }
}

extension AttributedString: StringStylable{
    func lineHeight(_ lineHeight: CGFloat) -> StringStylable {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        
        var attributedString = self
        attributedString.paragraphStyle = paragraphStyle
        return attributedString
    }
    
    func asAttributedString() -> AttributedString {
        self
    }
}

