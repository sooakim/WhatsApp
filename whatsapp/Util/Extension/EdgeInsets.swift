//
//  EdgeInsets.swift
//  whatsapp
//
//  Created by 김수아 on 1/13/24.
//

import Foundation
import SwiftUI

extension EdgeInsets{
    static let zero = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    
    init(all: CGFloat){
        self.init(top: all, leading: all, bottom: all, trailing: all)
    }
    
    init(vertical: CGFloat = 0, horizontal: CGFloat = 0){
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
}
