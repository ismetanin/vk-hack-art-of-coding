//
//  MapNavigationController.swift
//  sevcabel
//
//  Created by Anton Dryakhlykh on 10/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit

class MapNavigationController: UINavigationController {

    private var childARMapViewController: UIViewController?

    private let switcher = AttitudeSwitcher()

    // MARK: - Initialization and deinitialization

    convenience init() {
        self.init(rootViewController: MapViewController.fromStoryboard())
        configureAppearance()
    }

    // MARK: - Private helpers

    private func configureAppearance() {
        navigationBar.isTranslucent = true
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        configureAttitudeSwitcher()
    }
}

// MARK: - Switcher

extension MapNavigationController {
    private func configureAttitudeSwitcher() {
        
        self.switcher.switchHandler = { type in
            
            switch type {
            case .up:
                self.showCam()
            case .down:
                self.showMap()
            }
            
        }
        self.switcher.start()
        
    }
    
    private func makeARVC() -> UIViewController {
        let arMapVC = ARMapViewController(nibName: "ARMapViewController", bundle: nil)
        self.childARMapViewController = arMapVC
        return arMapVC
    }
    
    private func showMap() {
        self.childARMapViewController?.view.alpha = 0.0
        self.tabBarController?.hide(vc: childARMapViewController)
    }
    
    private func showCam() {
        let arVC = { () -> UIViewController in
            if let arVC = self.childARMapViewController {
                return arVC
            }
            return makeARVC()
        }()
        
        self.tabBarController?.show(vc: arVC)
    }
}

extension UIViewController {
    func transit(from startVC: UIViewController?, destination endVC: UIViewController?, style: UIView.AnimationOptions = .transitionCrossDissolve) {
        guard let startVC = startVC, children.contains(startVC) else {
            show(vc: endVC)
            return
        }
        
        guard let endVC = endVC else {
            hide(vc: startVC)
            return
        }
        
        self.addChild(endVC)
        startVC.willMove(toParent: nil)
        
        UIView.transition(from: startVC.view, to: endVC.view, duration: 0.5, options: style) { (final) in
            endVC.didMove(toParent: self)
            startVC.removeFromParent()
        }
    }
    
    func show(vc: UIViewController?) {
        guard let vc = vc else {
            return
        }
        
        self.addChild(vc)
        vc.viewWillAppear(true)
        view.addSubview(vc.view)
        vc.view.frame = view.bounds
        vc.didMove(toParent: self)
    }
    
    func hide(vc: UIViewController?, hideView:((UIView) -> Void)? = nil) {
        guard let vc = vc, children.contains(vc) else {
            return
        }
        
        vc.willMove(toParent: nil)
        
        if let hideView = hideView {
            hideView(vc.view)
        } else {
            vc.view.removeFromSuperview()
        }
        
        vc.removeFromParent()
    }
}
