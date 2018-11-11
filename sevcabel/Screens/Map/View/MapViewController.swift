//
//  MapViewController.swift
//  sevcabel
//
//  Created by Anton Dryakhlykh on 09/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Mapbox
import MapKit
import CoreLocation

final class MapViewController: UIViewController {
    
    // MARK: - Enums

    private enum Constants {
        static let title = "Что происходит"
        static let titleFontSize: CGFloat = 24.0
        static let titleColor = UIColor(red: 0.22, green: 0.23, blue: 0.28, alpha: 1.0)
        static let center = CLLocationCoordinate2D(latitude: 59.924303, longitude: 30.241221)
        static let zoomLevel = 15.8
        static let mapStyleURL = URL(string: "mapbox://styles/drxlx/cjobudxet2k6c2st8tv26vw49")
        static let topLeft = CLLocationCoordinate2D(latitude: 59.925371, longitude: 30.238593)
        static let topRight = CLLocationCoordinate2D(latitude: 59.925398, longitude: 30.243716)
        static let bottomRight = CLLocationCoordinate2D(latitude: 59.922833,
                                                        longitude: 30.243479)
        static let bottomLeft = CLLocationCoordinate2D(latitude: 59.922980,
                                                       longitude: 30.238486)
        static let imageName = "map"
        static let layerID = "layer"
    }

    // MARK: - Constants

    private let locationManager = CLLocationManager()

    // MARK: - Properties

    var mapView: MGLMapView?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        useLocation()
    }

    // MARK: - Private helpers

    private func setupInitialState() {
        configureNavigationBar()
        configureMapView()
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

    private func configureMapView() {
        let mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(Constants.center, zoomLevel: Constants.zoomLevel, animated: false)
        mapView.showsUserLocation = true
        mapView.styleURL = Constants.mapStyleURL
        mapView.attributionButton.alpha = 0.0
        mapView.delegate = self
        view.addSubview(mapView)

        self.mapView = mapView
    }

    private func useLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
}

// MARK: - MKMapViewDelegate

extension MapViewController: MGLMapViewDelegate {
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        let coordinates = MGLCoordinateQuad(
            topLeft: Constants.topLeft,
            bottomLeft: Constants.bottomLeft,
            bottomRight: Constants.bottomRight,
            topRight: Constants.topRight)

        guard let image = UIImage(named: Constants.imageName) else { return }
        let source = MGLImageSource(identifier: Constants.imageName,
                                    coordinateQuad: coordinates,
                                    image: image)

        style.addSource(source)

        let mapLayer = MGLRasterStyleLayer(identifier: Constants.layerID, source: source)

        for layer in style.layers.reversed() {
            if layer is MGLSymbolStyleLayer {
                style.insertLayer(mapLayer, above: layer)
                break
            }
        }
    }
}
