//
//  EarthquakesViewModel.swift
//  EarthquakesDemo
//
//  Created by Bogusław Parol on 16.06.2018.
//  Copyright © 2018 Bogusław Parol. All rights reserved.
//

import Foundation

class EarthquakesViewModel {
    
    private var geojson: Geojson? {
        didSet {
            self.earthquakesList.reloadList()
        }
    }
    
    var selectedPeriod = Period.defaultPeriod
    var selectedMagnitude = Magnitude.defaultMagnitude
    
    private weak var earthquakesList: EarthquakesList!
    
    private var apiClient : ApiClient!
    
    init(earthquakesList: EarthquakesList, networkService: ApiClient) {
        self.earthquakesList = earthquakesList
        self.apiClient = networkService
        self.fetchData(withIndicator: true)
    }
    
    func createFiltersViewModel() -> FiltersViewModel {
        return FiltersViewModel(
            selectedMagnitude: selectedMagnitude,
            selectedPeriod: selectedPeriod,
            onViewDisappear: { [weak self] (magnitude, period) in
                guard self != nil else {
                    return
                }
                
                if (magnitude != self!.selectedMagnitude) || (period != self!.selectedPeriod) {
                    self!.selectedMagnitude = magnitude
                    self!.selectedPeriod = period
                    self!.fetchData(withIndicator: true)
                }
        })
    }
    
    func createTweetsListViewModel(forRow row: Int) -> TweetsListViewModel? {
        guard let feature = self.geojson?.features?[row],
            let coordinates = feature.geometry?.coordinates, coordinates.count >= 2,
            let place = feature.properties?.place else {
            return nil
        }
        return TweetsListViewModel(coordinates: coordinates, location: place, apiClient: NetworkService())
    }

    func fetchData(withIndicator: Bool) {
        if withIndicator {
            self.earthquakesList.showLoadingIndicator()
        }
        self.apiClient.fetchGeodata(
            magnitude: selectedMagnitude,
            period: selectedPeriod,
            completion: { [weak self] (geojson) in
                self?.geojson = geojson
                if withIndicator {
                    self?.earthquakesList.hideLoadingIndicator()
                }
        }) { [weak self] in
            if withIndicator {
                self?.earthquakesList.hideLoadingIndicator()
            }
            // TODO: show error
        }
    }
    
    func onPullDownToRefresh() {
        self.fetchData(withIndicator: false)
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return geojson?.features?.count ?? 0
    }
    
    func earthquakeViewModel(forIndex index: Int) -> EarthquakeViewModel {
        if let feature = geojson?.features?[index] {
            return EarthquakeViewModel(feature: feature)
        }
        return EarthquakeViewModel()
    }
    
    func headerTitle() -> String {
        return "Magnitude: \(selectedMagnitude.type), period: last \(selectedPeriod.rawValue)"
    }
    
    func title() -> String {
        return "Earthquakes"
    }
}

class EarthquakeViewModel {
    
    private var feature: Feature!
    
    init() {
        
    }
    
    init(feature: Feature) {
        self.feature = feature
    }
    
    var location: String {
        return feature.properties?.place ?? Constants.notAvailable
    }
    
    var magnitude: String {
        if let mag = feature.properties?.mag {
            return "\(mag)"
        }
        return Constants.notAvailable
    }
    
    var time: String {
        if let time = feature.properties?.time {
            let date = Date(timeIntervalSince1970: time/1000)
            return CustomDateFormatter().toString(date: date)
        }
        return Constants.notAvailable
    }
}
