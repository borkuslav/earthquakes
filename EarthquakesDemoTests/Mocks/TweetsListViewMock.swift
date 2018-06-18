//
//  TweetsListViewMock.swift
//  EarthquakesDemoTests
//
//  Created by Boguslaw Parol on 18.06.2018.
//  Copyright © 2018 Bogusław Parol. All rights reserved.
//

import Foundation
@testable import EarthquakesDemo

class TweetsListViewMock: TweetsListView {
    
    var didCallReloadList = false
    func reloadList() {
        didCallReloadList = true
    }
    
    var didCallReloadHeader = false
    func reloadHeader() {
        didCallReloadHeader = true
    }
    
    var didCallShowLoadingIndicator = false
    func showLoadingIndicator() {
        didCallShowLoadingIndicator = true
    }
    
    var didCallHideLoadingIndicator = false
    func hideLoadingIndicator() {
        didCallHideLoadingIndicator = true
    }
}
