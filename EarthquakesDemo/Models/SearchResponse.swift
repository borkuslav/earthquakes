//
//  Tweets.swift
//  EarthquakesDemo
//
//  Created by Bogusław Parol on 17.06.2018.
//  Copyright © 2018 Bogusław Parol. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
    
    var statuses: [Status]?
}
