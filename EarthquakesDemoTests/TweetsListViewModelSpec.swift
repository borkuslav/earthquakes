//
//  TweetsListViewModelSpec.swift
//  EarthquakesDemoTests
//
//  Created by Boguslaw Parol on 18.06.2018.
//  Copyright © 2018 Bogusław Parol. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import EarthquakesDemo

class TweetsListViewModelSpec: QuickSpec {
    
    override func spec() {
        
        describe("TweetsListViewModel"){
            
            var sut: TweetsListViewModel!
            var apiClient: ApiClientMock!
            var searchResponse: SearchResponse!
            var coordinates: [Float]!
            var location: String!
            var tweetsListView: TweetsListViewMock!
            
            beforeEach {
                searchResponse = getSearchResponse()
                apiClient = ApiClientMock()
                coordinates = [134,-34]
                location = "New Guinea"
                tweetsListView = TweetsListViewMock()
                sut = TweetsListViewModel(coordinates: coordinates, location: location, apiClient: apiClient)
                sut.tweetsList = tweetsListView
            }
            
            describe("after initialization") {
            
                it("it should return correct title"){
                    expect(sut.title()) == location
                }
            }
            
            describe("before search should return default value for") {
                
                it("numberOfRows"){
                    expect(sut.numberOfRows()) == 0
                }
                
                it("radius title"){
                    expect(sut.radiusTitle()) == "Tweets from 100.0 km from \(location!)"
                }
            }
            
            describe("should show loading indicator on fetch") {
                
                beforeEach {
                    sut.fetchTweets()
                }
                
                it(""){
                    expect(tweetsListView.didCallShowLoadingIndicator) == true
                }
            
            }
            
            describe("after search") {
                
                beforeEach {
                    apiClient.fetchTweetsShouldComplete = true
                    apiClient.searchReponse = searchResponse
                    sut.fetchTweets()
                }
                
                it("should hide loading indicator"){
                    expect(tweetsListView.didCallHideLoadingIndicator) == true
                }
                
                it("should reload list"){
                    expect(tweetsListView.didCallReloadList) == true
                }
                
                it("should return correct numberOfRows"){
                    expect(sut.numberOfRows()) == searchResponse.statuses!.count
                }
                
                it("should return correct radius title"){
                    expect(sut.radiusTitle()) == "Tweets from 100.0 km from \(location!)"
                }
            }
            
            describe("when asked to update radius") {
                
                beforeEach {
                    sut.updateRadius(radius: 234.0)
                }
                
                it("it should return correct radius"){
                    expect(sut.getRadius()) == 234.0
                }
                
                it("it should reload header"){
                    expect(tweetsListView.didCallReloadHeader) == true
                }
                
                it("it should return correct header title"){
                    expect(sut.radiusTitle()) == "Tweets from 234.0 km from \(location!)"
                }
            }
            
            describe("on slider dragging finished") {
                
                beforeEach {
                    sut.sliderDidFinish()
                }
                
                it("it should fetch tweets"){
                    expect(apiClient.didCallFetchTweets) == true
                }
            }
        }        
    }
    
}
