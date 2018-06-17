//
//  FiltersViewModel.swift
//  EarthquakesDemo
//
//  Created by Bogusław Parol on 17.06.2018.
//  Copyright © 2018 Bogusław Parol. All rights reserved.
//

import Foundation

typealias FiltersViewCallback = ((Magnitude, Period) -> Void)

class FiltersViewModel {
    
    weak var filtersView: FiltersView!
    
    var selectedMagnitude: Magnitude!
    var selectedPeriod: Period!
    
    private var onViewDisappear: FiltersViewCallback!
    
    private enum Sections: Int {
        case period
        case magnitude
        
        static var count: Int {
            return Sections.magnitude.rawValue + 1
        }
    }
    
    private let periods = [
        0: Period.hour,
        1: Period.day,
        2: Period.week,
        3: Period.month
    ]
    
    init(selectedMagnitude: Magnitude, selectedPeriod: Period, onViewDisappear: @escaping FiltersViewCallback) {
        self.selectedMagnitude = selectedMagnitude
        self.selectedPeriod = selectedPeriod
        self.onViewDisappear = onViewDisappear
    }
    
    func title() -> String {
        return "Filters"
    }

    var numberOfSections: Int {
        return Sections.count
    }
    
    func titleForSection(_ section: Int) -> String {
        guard let section = Sections(rawValue: section) else {
            return ""
        }
        
        switch section {
        case .period:
            return "Time period"
        case .magnitude:
            return "Magnitude"
        }
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        guard let section = Sections(rawValue: section) else {
            return 0
        }
        
        switch section {
        case .period:
            return Period.count
        case .magnitude:
            return Magnitude.count
        }
    }
    
    func titleForRow(inSection section: Int, atIndex index: Int) -> String {
        guard let section = Sections(rawValue: section) else {
            return ""
        }
        
        switch section {
        case .period:
            return periods[index]?.rawValue ?? ""
        case .magnitude:
            return Magnitude(rawValue: index)?.type ?? ""
        }
    }
    
    func didSelect(item: Int, atSection section: Int) {
        
        guard let section = Sections(rawValue: section) else {
            return
        }
        
        switch section{
        case .period:
            selectedPeriod = periods[item]
        case .magnitude:
            selectedMagnitude = Magnitude(rawValue: item)
        }
        filtersView.reloadFiltersView()
    }
    
    func isSelected(item: Int, atSection section: Int) -> Bool {
        
        guard let section = Sections(rawValue: section) else {
            return false
        }
        
        switch section{
        case .period:
            return periods[item] == selectedPeriod
        case .magnitude:
            return selectedMagnitude.rawValue == item
        }
    }
    
    func viewWillDisappear() {
        onViewDisappear(selectedMagnitude, selectedPeriod)
    }
}
