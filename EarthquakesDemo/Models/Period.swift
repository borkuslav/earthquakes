//
//  Period.swift
//  EarthquakesDemo
//
//  Created by Bogusław Parol on 16.06.2018.
//  Copyright © 2018 Bogusław Parol. All rights reserved.
//

import Foundation

enum Period: String {
    
    case hour
    case day
    case week
    case month
    
    static var count: Int {
        return 4
    }
    
    static var defaultPeriod: Period {
        return .month
    }
}
