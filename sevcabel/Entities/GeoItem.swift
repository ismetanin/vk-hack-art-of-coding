//
//  GeoItem.swift
//  ARLocatorTest
//
//  Created by Gregory Berngardt on 10/11/2018.
//  Copyright © 2018 gregoryvit. All rights reserved.
//

import Foundation

struct GeoItem: Codable {
    let id: String
    let title: String
    let summary: String
    let latitude: Double
    let longitude: Double
    let altitude: Double
    let timestamp: Int
    let type: String
    let urgency: Int
    
    init(id: String, title: String, summary: String, latitude: Double, longitude: Double, altitude: Double, type: String, urgency: Int) {
        self.id = id
        self.title = title
        self.summary = summary
        self.latitude = latitude
        self.longitude = longitude
        self.altitude = altitude
        self.timestamp = Int(Date().timeIntervalSince1970)
        self.type = type
        self.urgency = urgency
    }
}
