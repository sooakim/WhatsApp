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

extension Date{
    func asRelativeDateTime() -> String{
        let dateComponents = Calendar.gmt.dateComponents([.minute, .hour, .day], from: self, to: Date())
        
        let minutes = dateComponents.minute ?? .zero
        if minutes < 1{
            return "지금"
        }
        
        let hours = dateComponents.hour ?? .zero
        if hours < 1{
            return String(format: "%d분 전", minutes)
        }
        
        let days = dateComponents.hour ?? .zero
        if days < 1{
            return String(format: "%d시간 전", hours)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }
}
