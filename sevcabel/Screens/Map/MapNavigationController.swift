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
    private var childARMapViewControllerIsPresented = false

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
                self.showAR()
            case .down:
                self.childARMapViewController?.dismiss(animated: true, completion: {
                })
                self.childARMapViewControllerIsPresented = false
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
        guard let childARVC = childARMapViewController, childARVC.isBeingPresented else {
            return
        }
        
        childARMapViewController?.dismiss(animated: true, completion: nil)
        
//        self.tabBarController?.hide(vc: childARMapViewController)
    }
    
    private func showAR() {
        let arVC = { () -> UIViewController in
            if let arVC = self.childARMapViewController {
                return arVC
            }
            return makeARVC()
        }()
        
        guard !childARMapViewControllerIsPresented else {
            return
        }
        
        childARMapViewControllerIsPresented = true
        self.tabBarController?.present(arVC, animated: true, completion: nil)
        
//        self.tabBarController?.show(vc: arVC)
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
