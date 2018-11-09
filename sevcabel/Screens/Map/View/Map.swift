//
//  Map.swift
//  sevcabel
//
//  Created by Anton Dryakhlykh on 10/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import MapKit

final class Map {

    // MARK: - Constants

    let center = CLLocationCoordinate2D(latitude: 59.924303, longitude: 30.241221)

    let edgeLocations = [
        CLLocationCoordinate2D(latitude: 59.925358, longitude: 30.240450),
        CLLocationCoordinate2D(latitude: 59.924733, longitude: 30.241482),
        CLLocationCoordinate2D(latitude: 59.923965, longitude: 30.243686),
        CLLocationCoordinate2D(latitude: 59.922957, longitude: 30.242193),
        CLLocationCoordinate2D(latitude: 59.923795, longitude: 30.240136),
        CLLocationCoordinate2D(latitude: 59.924645, longitude: 30.238518)
    ]

    private let topLeft = CLLocationCoordinate2D(latitude: 59.925371, longitude: 30.238593)
    private let bottomLeft = CLLocationCoordinate2D(latitude: 59.922980, longitude: 30.238486)
    private let topRight = CLLocationCoordinate2D(latitude: 59.925398, longitude: 30.243716)

    // MARK: - Properties

    var boundingMapRect: MKMapRect {
        let x = MKMapPoint(topLeft).x
        let y = MKMapPoint(topLeft).y
        let width = fabs(MKMapPoint(topLeft).x - MKMapPoint(topRight).x)
        let height = fabs(MKMapPoint(topLeft).y - MKMapPoint(bottomLeft).y)
        return MKMapRect(x: x, y: y, width: width, height: height)
    }
}
