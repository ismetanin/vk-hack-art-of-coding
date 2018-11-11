//
//  DrawerDismissTransition.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 11/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit

final class DrawerDismissTransition: NSObject, UIViewControllerAnimatedTransitioning {

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
        containerView.addSubview(fromViewController.view)

        let shadowView = toViewController.view.subviews.first(where: {
            $0.restorationIdentifier == Constants.shadowViewRestorationIdentifier
        })

        UIView.animate(
            withDuration: Constants.animationDuration,
            animations: {
                shadowView?.alpha = 0.0
                fromViewController.view.frame.origin.y = fromViewController.view.frame.height
            },
            completion: { _ in
                shadowView?.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }

}
