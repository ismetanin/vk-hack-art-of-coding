//
//  MapOverlayRenderer.swift
//  sevcabel
//
//  Created by Anton Dryakhlykh on 10/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import MapKit

final class MapOverlayRenderer: MKOverlayRenderer {

    // MARK: - Enums

    private enum Constants {
        static let scale: CGFloat = 1.0
        static let imageName = "map"
    }

    // MARK: - MKOverlayRenderer

    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        guard let image = #imageLiteral(resourceName: "map.png").cgImage else { return }

        let rect = self.rect(for: overlay.boundingMapRect)
        context.scaleBy(x: Constants.scale, y: -Constants.scale)
        context.translateBy(x: 0.0, y: -rect.size.height)
        context.draw(image, in: rect)
    }
}
