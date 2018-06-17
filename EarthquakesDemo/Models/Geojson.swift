//
//  Geojson.swift
//  EarthquakesDemo
//
//  Created by Bogusław Parol on 15.06.2018.
//  Copyright © 2018 Bogusław Parol. All rights reserved.
//

import Foundation

struct Geojson: Decodable {
    var metadata: Metadata?
    var features: [Feature]?
}

struct Metadata: Decodable {
    var title: String?
}

struct Feature: Decodable {
    var type: String?
    var properties: Properties?
    var geometry: Geometry?
    var id: String?    
}

struct Properties: Decodable {
    var place: String?
    var mag: Float?
    var time: Double?
    
}

struct Geometry: Decodable {
    var type: String?
    var coordinates: [Float]?
}


