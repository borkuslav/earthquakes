//
//  TestData.swift
//  EarthquakesDemoTests
//
//  Created by Boguslaw Parol on 18.06.2018.
//  Copyright © 2018 Bogusław Parol. All rights reserved.
//

import Foundation
@testable import EarthquakesDemo

func getSearchResponse() -> SearchResponse {
    
    let statuses = [
        Status(text: "Earthquake tweet 1",
               user: User(name: "User1", profile_image_url: "http:example1.com"),
               created_at: "Wed Dec 19 20:20:32 +0000 2007"),
        Status(text: "Earthquake tweet 2",
               user: User(name: "User2", profile_image_url: "http:example2.com"),
               created_at: "Wed Dec 19 20:20:32 +0000 2007"),
        Status(text: "Earthquake tweet 3",
               user: User(name: "User3", profile_image_url: "http:example3.com"),
               created_at: "Wed Dec 19 20:20:32 +0000 2007")
    ]
    
    return SearchResponse(statuses: statuses)
}

