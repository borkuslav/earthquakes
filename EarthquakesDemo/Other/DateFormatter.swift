//
//  DateFormatter.swift
//  EarthquakesDemo
//
//  Created by Bogusław Parol on 17.06.2018.
//  Copyright © 2018 Bogusław Parol. All rights reserved.
//

import Foundation

class CustomDateFormatter {
    
    func toString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: date)
    }
}
