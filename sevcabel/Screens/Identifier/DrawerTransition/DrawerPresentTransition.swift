//
//  DrawerPresentTransition.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 11/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit

final class DrawerPresentTransition: NSObject, UIViewControllerAnimatedTransitioning {

    // MARK: - Enums

    private enum Constants {
        static let animationDuration = 0.25
        static let shadowViewRestorationIdentifier = "ShadowDrawerView"
    }

    // MARK: - UIViewControllerAnimatedTransitioning

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Constants.animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to)
            else {
                return
        }

        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)

        let shadowView = UIView()
        shadowView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        shadowView.frame = toViewController.view.bounds
        shadowView.alpha = 0.0
        shadowView.restorationIdentifier = "ShadowDrawerView"
        fromViewController.view.addSubview(shadowView)

        toViewController.view.frame.origin.y = toViewController.view.frame.height

        UIView.animate(
            withDuration: Constants.animationDuration,
            animations: {
                shadowView.alpha = 1.0
                toViewController.view.frame.origin.y = 0.0
        },
            completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        )
    }

}
