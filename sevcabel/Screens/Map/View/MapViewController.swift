//
//  MapViewController.swift
//  sevcabel
//
//  Created by Anton Dryakhlykh on 09/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import MapKit
import CoreLocation

final class MapViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak private var mapView: MKMapView!

    // MARK: - Enums

    private enum Constants {
        static let distanceToCamera: Double = 300.0
        static let title = "Что происходит"
        static let titleFontSize: CGFloat = 24.0
        static let titleColor = UIColor(red: 0.22, green: 0.23, blue: 0.28, alpha: 1.0)
    }

    // MARK: - Constants

    private let map = Map()
    private let locationManager = CLLocationManager()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        useLocation()
    }

    // MARK: - Private helpers

    private func setupInitialState() {
        let region = MKCoordinateRegion(center: map.center,
                                        latitudinalMeters: Constants.distanceToCamera,
                                        longitudinalMeters: Constants.distanceToCamera)

        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        mapView.delegate = self

        configureNavigationBar()
        removeMapBackground()
        addMapImage()
    }

    private func configureNavigationBar() {
        navigationItem.title = nil
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: Constants.title,
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
        let font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.foregroundColor: Constants.titleColor]
        navigationItem.leftBarButtonItem?.setTitleTextAttributes(attributes,
                                                                 for: .normal)
    }

    private func removeMapBackground() {
        let tiles = MKTileOverlay(urlTemplate: nil)
        tiles.canReplaceMapContent = true
//        mapView.addOverlay(tiles)
    }

    private func addMapImage() {
        let mapOverlay = MapOverlay(map: map)
        mapView.addOverlay(mapOverlay)
    }

    private func useLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MapOverlay {
            return MapOverlayRenderer(overlay: overlay)
        } else if overlay is MKTileOverlay {
            return MKTileOverlayRenderer(overlay: overlay)
        } else {
            return MKOverlayRenderer()
        }
    }
}
