//
//  Calendar.swift
//  whatsapp
//
//  Created by 김수아 on 1/13/24.
//

import Foundation

extension Calendar{
    static let gmt = { () -> Calendar in
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        return calendar
    }()
}
