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
    
    private var networkService : NetworkService!
    
    init(earthquakesList: EarthquakesList, networkService: NetworkService) {
        self.earthquakesList = earthquakesList
        self.networkService = networkService
        self.fetchData()
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
                    self!.fetchData()
                }
        })
    }

    func fetchData() {
        self.earthquakesList.showLoadingIndicator()
        self.networkService.fetchGeodata(
            magnitude: selectedMagnitude,
            period: selectedPeriod,
            completion: { [weak self] (geojson) in
                self?.geojson = geojson
                self?.earthquakesList.hideLoadingIndicator()
        }) { [weak self] in
            self?.earthquakesList.hideLoadingIndicator()
            // TODO: show error
        }
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
