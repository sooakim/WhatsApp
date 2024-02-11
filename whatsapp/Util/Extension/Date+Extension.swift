//
//  Date+Extension.swift
//  whatsapp
//
//  Created by 김수아 on 2/11/24.
//

import Foundation

extension Date{
    init?(iso8601: String){
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone.current
        
        guard let date = formatter.date(from: iso8601) else{ return nil }
        self = date
    }
}
