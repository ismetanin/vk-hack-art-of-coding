//
//  PointAnnotation.swift
//  sevcabel
//
//  Created by Anton Dryakhlykh on 11/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Mapbox

final class PointAnnotation: MGLPointAnnotation {

    // MARK: - Enums

    enum AnnotationType: String {
        case beer
        case fork
        case music
        case toilet
        case binoculars
        case child
        case coffee
        case shop
        case star
    }

    private enum Constants {
        static let pulse = "pulse-"
    }

    // MARK: - Constants

    private let type: AnnotationType

    // MARK: - Properties

    var image: MGLAnnotationImage? {
        return MGLAnnotationImage(image: UIImage(named: type.rawValue) ?? UIImage(),
                                  reuseIdentifier: type.rawValue)
    }

    var pulsingImage: UIImage? {
        return UIImage(named: Constants.pulse + type.rawValue)
    }

    var isPulsing = false

    // MARK: - Initialization and deinitialization

    init(type: AnnotationType, coordinate: CLLocationCoordinate2D) {
        self.type = type
        super.init()
        self.coordinate = coordinate
    }

    required init?(coder aDecoder: NSCoder) {
        self.type = .beer
        super.init(coder: aDecoder)
    }
}
