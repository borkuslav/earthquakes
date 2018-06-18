//
//  ApiClientMock.swift
//  EarthquakesDemoTests
//
//  Created by Boguslaw Parol on 18.06.2018.
//  Copyright © 2018 Bogusław Parol. All rights reserved.
//

import Foundation
@testable import EarthquakesDemo

class ApiClientMock: ApiClient {
        
    var fetchGeodataShouldComplete: Bool!
    var geojson: Geojson!
    func fetchGeodata(magnitude: Magnitude, period: Period, completion: @escaping (Geojson) -> Void, failure: @escaping () -> Void) {
        if fetchGeodataShouldComplete {
            completion(geojson)
        } else {
            failure()
        }
    }
    
    var didCallFetchTweets = false
    var fetchTweetsShouldComplete: Bool?
    var searchReponse: SearchResponse?
    func fetchTweets(coordinates: [Float], radius: Float, completion: @escaping (SearchResponse) -> Void, failure: @escaping () -> Void) {
        didCallFetchTweets = true
        if let shouldComplete = fetchTweetsShouldComplete {
            shouldComplete ? completion(searchReponse!) : failure()
        }
    }
}
