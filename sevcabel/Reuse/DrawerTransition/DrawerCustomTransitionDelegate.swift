//
//  DrawerCustomTransitionDelegate.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 11/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit

final class DrawerCustomTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {

    // MARK: - Constants

    private let interactiveTransition = UIPercentDrivenInteractiveTransition()

    // MARK: - Properties

    var shouldDoInteractive = false

    // MARK: - Internal helpers

    func update(with progress: Float) {
        interactiveTransition.update(CGFloat(progress))
    }

    func finish() {
        interactiveTransition.finish()
    }

    func cancel() {
        interactiveTransition.cancel()
    }

    // MARK: - UIViewControllerTransitioningDelegate

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DrawerPresentTransition()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DrawerDismissTransition()
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return shouldDoInteractive ? interactiveTransition : nil
    }

}
