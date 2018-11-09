//
//  MapOverlay.swift
//  sevcabel
//
//  Created by Anton Dryakhlykh on 10/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import MapKit

final class MapOverlay: NSObject, MKOverlay {

    // MARK: - MKOverlay

    var coordinate: CLLocationCoordinate2D
    var boundingMapRect: MKMapRect

    // MARK: - Initialization and deinitialization

    init(map: Map) {
        coordinate = map.center
        boundingMapRect = map.boundingMapRect
    }
}
