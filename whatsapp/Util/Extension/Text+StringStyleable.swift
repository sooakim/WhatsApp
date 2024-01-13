//
//  Text+StringStyleable.swift
//  whatsapp
//
//  Created by 김수아 on 1/14/24.
//

import Foundation
import SwiftUI

extension Text{
    init(styleable: StringStylable){
        self.init(styleable.asAttributedString())
    }
}
