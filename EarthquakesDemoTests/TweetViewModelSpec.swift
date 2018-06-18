//
//  TweetViewModelSpec.swift
//  EarthquakesDemoTests
//
//  Created by Boguslaw Parol on 18.06.2018.
//  Copyright © 2018 Bogusław Parol. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import EarthquakesDemo

class TweetViewModelSpec: QuickSpec {
    
    override func spec() {
        
        describe("TweetViewModel"){
        
            var sut: TweetViewModel!
            var status: Status!
            
            beforeEach {
                status = getSearchResponse().statuses![0]
                sut = TweetViewModel(status: status)
            }
            
            describe("should return correct") {
                
                it("username"){
                    expect(sut.username()) == status.user!.name
                }
                
                it("text"){
                    expect(sut.text()) == status.text
                }
                
                it("date"){
                    expect(sut.date()) == "Wed Dec 19 2007"
                }
                
                it("url"){
                    expect(sut.userImageUrl()) == status.user?.profile_image_url
                }
            }
        }
    }

}
