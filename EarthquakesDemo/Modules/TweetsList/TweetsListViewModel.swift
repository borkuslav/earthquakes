//
//  TweetsListViewModel.swift
//  EarthquakesDemo
//
//  Created by Bogusław Parol on 17.06.2018.
//  Copyright © 2018 Bogusław Parol. All rights reserved.
//

import Foundation

class TweetsListViewModel {
    
    weak var tweetsList: TweetsListView!
    
    private var coordinates: [Float]!
    private var location: String!
    private var networkService: NetworkService!
    
    private static var radius: Float = 100
    
    private var searchResponse: SearchResponse! {
        didSet {
            self.tweetsList.reloadList()
        }
    }
    
    init(coordinates: [Float], location: String, networkService: NetworkService) {
        self.coordinates = coordinates
        self.location = location
        self.networkService = networkService
    }
    
    func title() -> String{
        return location
    }
    
    func fetchTweets() {
        tweetsList.showLoadingIndicator()
        networkService.fetchTweets(coordinates: coordinates, radius: getRadius(), completion: { [weak self] (response) in
            self?.searchResponse = response
            self?.tweetsList.hideLoadingIndicator()
        }, failure: { [weak self] in
            // TODO: show error
            self?.tweetsList.hideLoadingIndicator()
        })
    }
    
    func numberOfRows() -> Int {
        return searchResponse?.statuses?.count ?? 0
    }
    
    func tweetViewModel(forIndex index: Int) -> TweetViewModel {
        guard let status = self.searchResponse?.statuses?[index] else {
            return TweetViewModel()
        }
        return TweetViewModel(status: status)
    }
    
    func radiusTitle() -> String {
        return "Tweets from \(TweetsListViewModel.radius) km from \(location!)"
    }
    
    func updateRadius(radius: Float) {
        TweetsListViewModel.radius = radius
        tweetsList.reloadHeader()
    }
    
    func sliderDidFinish() {
        fetchTweets()
    }
    
    func getRadius() -> Float {
        return TweetsListViewModel.radius
    }
}

class TweetViewModel {
    
    private var status: Status!
    
    init() {
        
    }
    
    init(status: Status) {
        self.status = status
    }
    
    func username() -> String {
        return self.status.user?.name ?? ""
    }
    
    func text() -> String {
        return self.status.text ?? ""
    }
    
    func date() -> String {
        if let createdDate = status.created_at{
            if let readableDate = CustomDateFormatter().twitterDateHumanReadable(twitterDateString: createdDate) {
                return readableDate
            }
        }
        return Constants.notAvailable
    }
    
    func userImageUrl() -> String? {
        return status.user?.profile_image_url?.replacingOccurrences(of: "http://", with: "https://")
    }
}
