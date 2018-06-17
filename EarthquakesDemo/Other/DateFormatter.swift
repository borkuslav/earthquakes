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
    
    func twitterDateHumanReadable(twitterDateString: String) -> String? {
        let df = DateFormatter()
        //Wed Dec 01 17:08:03 +0000 2010
        df.dateFormat = "eee MMM dd HH:mm:ss ZZZZ yyyy"
        if let date = df.date(from: twitterDateString) {
            df.dateFormat = "eee MMM dd yyyy"
            return df.string(from: date)
        }
        return nil
    }
}
