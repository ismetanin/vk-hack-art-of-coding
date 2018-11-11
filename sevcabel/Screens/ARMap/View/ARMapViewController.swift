//
//  ARMapViewController.swift
//  sevcabel
//
//  Created by Gregory Berngardt on 11/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit

import ARCL
import MapKit
import SceneKit
import Speech


class ARMapViewController: UIViewController {
    var sceneLocationView: SceneLocationView?
    
    private var annotations: [String: MKAnnotation] = [:]
    private var nodes: [String: LocationNode] = [:]
    
    var infoLabel = UILabel()
    
    var updateInfoLabelTimer: Timer?
    
    var adjustNorthByTappingSidesOfScreen = false
    
    // Speech recogniton
    
    let skManager = AppleSpeechKitManager()
    var recordedText: String? {
        didSet {
            realtimeLabel.text = recordedText
        }
    }
    
    private let switcher: AttitudeSwitcher = AttitudeSwitcher()
    
    // Data
    
    var dbManager: FirebaseDatabase?
    
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var realtimeLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func startTouch(_ sender: Any) {
        self.recordedText = ""
        skManager.start { (text) in
            self.recordedText = text
        }
    }
    
    @IBAction func endTouch(_ sender: Any) {
        skManager.stop()
        
        if let text = recordedText {
            makeItemWith(text: text)
        }
        
        self.recordedText = nil
    }
    
    @IBAction func reactionPressed(_ sender: UIButton) {
        if let text = sender.title(for: .normal) {
            makeItemWith(text: text)
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func makeItemWith(text: String) {
        let annotationNode = TextCardNode(location: nil, title: text, summary: nil)
        annotationNode.scaleRelativeToDistance = false
        self.sceneLocationView?.addLocationNodeForCurrentPosition(locationNode: annotationNode)
        annotationNode.locationConfirmed = true
        
        let geoItem = GeoItem(id: "\(Int(Date().timeIntervalSince1970))", title: text, summary: "", latitude: annotationNode.location.coordinate.latitude, longitude: annotationNode.location.coordinate.longitude, altitude:  annotationNode.location.altitude, type: "user", urgency: 0)
        
        dbManager?.postItem(geoItem)
        
        self.sceneLocationView?.removeLocationNode(locationNode: annotationNode)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDatabase()
        
        configureInfoLabel()
        configureSceneLocationView()
        configureSpeechRecognition()
        configureMapView()
//        configureAttitudeSwitcher()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sceneLocationView?.run()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneLocationView?.pause()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sceneLocationView?.frame = view.bounds
        
        updateInfoLabelLayout()
        mapToSmallView()

    }
    
    private func configureSpeechRecognition() {
        self.recordedText = nil
        
        skManager.requestSpeechAuthorization { isAuthorized in
            self.createButton.isEnabled = isAuthorized
        }
    }
    
    private func configureMapView() {
        mapView.showsUserLocation = true
        mapView.isRotateEnabled = true
        mapView.userTrackingMode = .followWithHeading
        
        mapView.clipsToBounds = true
        
        mapView.alpha = 0.9
        
        mapView.translatesAutoresizingMaskIntoConstraints = true
        
        mapToSmallView()
    }
    
//    private func configureAttitudeSwitcher() {
//
//        self.switcher.switchHandler = { type in
//
//            switch type {
//            case .up:
//                self.mapToSmallView()
//            case .down:
//                self.mapToFullScreen()
//            }
//
//        }
//        self.switcher.start()
//
//    }
    
    private func mapToSmallView() {
        
        UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
            self.mapView.frame = CGRect(x: (self.view.bounds.width - 250.0) / 2.0, y: self.view.bounds.height - 250.0, width: 250.0, height: 250.0)
            self.mapView.layer.cornerRadius = 125
            self.mapView.alpha = 0.9
            }.startAnimation()
        
    }
    
    private func mapToFullScreen() {
        UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
            self.mapView.frame = self.view.bounds
            self.mapView.layer.cornerRadius = 0.0
            self.mapView.alpha = 1.0
            }.startAnimation()
        
    }
    
    private func configureDatabase() {
        self.dbManager = FirebaseDatabase()
        
        self.dbManager?.itemsUpdate = { items in
            for item in items {
                let node = self.buildNode(latitude: item.latitude, longitude: item.longitude, altitude: item.altitude, imageName: "", title: item.title, summary: item.summary, urgencyLevel: item.urgency)
                node.scaleRelativeToDistance = false
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
                annotation.title = item.title
                annotation.subtitle = item.summary
                
                if let previousNode = self.nodes[item.id] {
                    self.sceneLocationView?.removeLocationNode(locationNode: previousNode)
                }
                
                if let previousAnnotation = self.annotations[item.id] {
                    self.mapView.removeAnnotation(previousAnnotation)
                }
                
                self.mapView.addAnnotation(annotation)
                self.sceneLocationView?.addLocationNodeWithConfirmedLocation(locationNode: node)
                
                self.nodes[item.id] = node
                self.annotations[item.id] = annotation
            }
            
            self.mapView.userTrackingMode = .followWithHeading
        }
        
        self.dbManager?.itemsRemove = { items in
            for item in items {
                if let previousAnnotation = self.annotations[item.id] {
                    self.mapView.removeAnnotation(previousAnnotation)
                }
                
                if let previousNode = self.nodes[item.id] {
                    self.sceneLocationView?.removeLocationNode(locationNode: previousNode)
                }
                
                self.nodes.removeValue(forKey: item.id)
                self.annotations.removeValue(forKey: item.id)
            }
            
            self.mapView.userTrackingMode = .followWithHeading
        }
        
        self.dbManager?.startListenItems()
    }
    
}

// MARK: - Info label

private extension ARMapViewController {
    
    func configureInfoLabel() {
        infoLabel.font = UIFont.systemFont(ofSize: 10)
        infoLabel.textAlignment = .left
        infoLabel.textColor = UIColor.white
        infoLabel.numberOfLines = 0
        sceneLocationView?.addSubview(infoLabel)
        
        updateInfoLabelTimer = Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(ARMapViewController.updateInfoLabel),
            userInfo: nil,
            repeats: true)
    }
    
    func updateInfoLabelLayout() {
        infoLabel.frame = CGRect(x: 6, y: 0, width: self.view.frame.size.width - 12, height: 14 * 4)
        
        infoLabel.frame.origin.y = self.view.frame.size.height - infoLabel.frame.size.height
    }
    
    
    
    @objc func updateInfoLabel() {
        if let position = sceneLocationView?.currentScenePosition() {
            infoLabel.text = "x: \(String(format: "%.2f", position.x)), y: \(String(format: "%.2f", position.y)), z: \(String(format: "%.2f", position.z))\n"
        }
        
        if let eulerAngles = sceneLocationView?.currentEulerAngles() {
            infoLabel.text!.append("Euler x: \(String(format: "%.2f", eulerAngles.x)), y: \(String(format: "%.2f", eulerAngles.y)), z: \(String(format: "%.2f", eulerAngles.z))\n")
        }
        
        if let location = sceneLocationView?.currentLocation() {
            infoLabel.text!.append("Latitude: \(location.coordinate.latitude), longitude: \(location.coordinate.longitude)")
        }
        
        if let heading = sceneLocationView?.locationManager.heading,
            let accuracy = sceneLocationView?.locationManager.headingAccuracy {
            infoLabel.text!.append("Heading: \(heading)º, accuracy: \(Int(round(accuracy)))º\n")
        }
        
        
        let date = Date()
        let comp = Calendar.current.dateComponents([.hour, .minute, .second, .nanosecond], from: date)
        
        if let hour = comp.hour, let minute = comp.minute, let second = comp.second, let nanosecond = comp.nanosecond {
            infoLabel.text!.append("\(String(format: "%02d", hour)):\(String(format: "%02d", minute)):\(String(format: "%02d", second)):\(String(format: "%03d", nanosecond / 1000000))")
        }
    }
}

// MARK: - Location base methods

private extension ARMapViewController {
    
    func configureSceneLocationView() {
        
        let sceneLocationView = SceneLocationView()
        
        sceneLocationView.showAxesNode = false
        sceneLocationView.locationDelegate = self
        sceneLocationView.orientToTrueNorth = true
                
        view.insertSubview(sceneLocationView, at: 0)
        
        self.sceneLocationView = sceneLocationView
    }
    
    @objc func updateUserLocation() {
        guard let currentLocation = sceneLocationView?.currentLocation() else {
            return
        }
        
        DispatchQueue.main.async {
            if let bestEstimate = self.sceneLocationView?.bestLocationEstimate(),
                let position = self.sceneLocationView?.currentScenePosition() {
                print("")
                print("Fetch current location")
                print("best location estimate, position: \(bestEstimate.position), location: \(bestEstimate.location.coordinate), accuracy: \(bestEstimate.location.horizontalAccuracy), date: \(bestEstimate.location.timestamp)")
                print("current position: \(position)")
                
                let translation = bestEstimate.translatedLocation(to: position)
                
                print("translation: \(translation)")
                print("translated location: \(currentLocation)")
                print("")
            }
        }
    }
}

// MARK: - SceneLocationViewDelegate

extension ARMapViewController: SceneLocationViewDelegate {
    func sceneLocationViewDidAddSceneLocationEstimate(sceneLocationView: SceneLocationView, position: SCNVector3, location: CLLocation) {
        print("add scene location estimate, position: \(position), location: \(location.coordinate), accuracy: \(location.horizontalAccuracy), date: \(location.timestamp)")
    }
    
    func sceneLocationViewDidRemoveSceneLocationEstimate(sceneLocationView: SceneLocationView, position: SCNVector3, location: CLLocation) {
        print("remove scene location estimate, position: \(position), location: \(location.coordinate), accuracy: \(location.horizontalAccuracy), date: \(location.timestamp)")
    }
    
    func sceneLocationViewDidConfirmLocationOfNode(sceneLocationView: SceneLocationView, node: LocationNode) {
    }
    
    func sceneLocationViewDidSetupSceneNode(sceneLocationView: SceneLocationView, sceneNode: SCNNode) {
        
    }
    
    func sceneLocationViewDidUpdateLocationAndScaleOfLocationNode(sceneLocationView: SceneLocationView, locationNode: LocationNode) {
        
    }
}

// MARK: - Data Helpers

private extension ARMapViewController {
    func buildNode(latitude: CLLocationDegrees, longitude: CLLocationDegrees, altitude: CLLocationDistance, imageName: String, title: String, summary: String, urgencyLevel: Int) -> TextCardNode {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let location = CLLocation(coordinate: coordinate, altitude: altitude)
        
        let resultNode = TextCardNode(location: location, title: title, summary: summary, urgencyLevel: urgencyLevel)
        //        let resultNode = LocationAnnotationNode(location: location, image: image)
        resultNode.scaleRelativeToDistance = false
        return resultNode
    }
}

// MARK: - Switcher

extension ARMapViewController {
    private func configureAttitudeSwitcher() {
        
        self.switcher.switchHandler = { type in
            
            switch type {
            case .up:
                return
            case .down:
                self.switcher.stop()
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        self.switcher.start()
        
    }
}
