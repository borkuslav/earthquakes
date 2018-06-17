//
//  TweetsListViewModel.swift
//  EarthquakesDemo
//
//  Created by Bogusław Parol on 17.06.2018.
//  Copyright © 2018 Bogusław Parol. All rights reserved.
//

import Foundation

class TweetsListViewModel {
    
    private var coordinates: [Float]!
    private var networkService: NetworkService!
    
    init(coordinates: [Float], networkService: NetworkService) {
        self.coordinates = coordinates        
        self.networkService = networkService
    }
    
    func fetchTweets() {
        networkService.fetchTweets(coordinates: coordinates, completion: { (response) in
            debugPrint("")
        }, failure: {
            debugPrint("")
        })
    }
}
