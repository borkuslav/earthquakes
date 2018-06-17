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
                    failure()
                    break
                }
        }
    }
}
