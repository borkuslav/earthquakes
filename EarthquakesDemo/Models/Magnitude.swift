//
//  Magnitude.swift
//  EarthquakesDemo
//
//  Created by Bogusław Parol on 16.06.2018.
//  Copyright © 2018 Bogusław Parol. All rights reserved.
//

import Foundation

enum Magnitude: Int {
    
    case all
    case above_1_0
    case above_2_5
    case above_4_5
    case significant
    
    var type: String {
        switch self {
        case .all:
            return "all"
        case .above_1_0:
            return "1.0"
        case .above_2_5:
            return "2.5"
        case .above_4_5:
            return "4.5"
        case .significant:
            return "significant"
        }
    }
    
    static var count: Int {
        return Magnitude.significant.rawValue + 1
    }
    
    static var defaultMagnitude: Magnitude {
        return .above_4_5
    }
}
