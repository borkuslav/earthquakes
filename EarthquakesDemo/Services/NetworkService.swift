//
//  NetworkService.swift
//  EarthquakesDemo
//
//  Created by Bogusław Parol on 15.06.2018.
//  Copyright © 2018 Bogusław Parol. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService{
    
    func fetchGeodata(magnitude: Magnitude, period: Period, completion: @escaping (Geojson) -> Void, failure: @escaping () -> Void) {
        
        let url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/\(magnitude.type)_\(period).geojson"
        Alamofire
            .request(url)
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    guard let jsonData = try? JSONSerialization.data(withJSONObject: data),
                        let geodata = try? JSONDecoder().decode(Geojson.self, from: jsonData)
                    else {
                        failure()
                        return
                    }
                    completion(geodata)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    failure()
                    break
                }
        }
    }
    
    let twitterApiClient = TWTRAPIClient()
    func fetchTweets(coordinates: [Float], radius: Float, completion: @escaping (SearchResponse) -> Void, failure: @escaping () -> Void) {
        
        let client = TWTRAPIClient()
        let tweetsUrl = "https://api.twitter.com/1.1/search/tweets.json?q=earthquake&geocode=\(coordinates[1]),\(coordinates[0]),\(Int(radius))km&count=100"
        var clientError : NSError?
        
        let request = client.urlRequest(withMethod: "GET", urlString: tweetsUrl, parameters: nil, error: &clientError)
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            guard let data = data, connectionError == nil else {
                failure()
                return
            }
            
            guard let res = try? JSONDecoder().decode(SearchResponse.self, from: data) else {
                failure()
                return
            }
            
            completion(res)
        }
    }
}
