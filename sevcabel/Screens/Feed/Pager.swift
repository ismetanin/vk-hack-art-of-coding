//
//  SegmentedPageController.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 10/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit

class Pager {

    // MARK: - Private fileds

    private var pageViewContainer: UIView

    private var parent: UIViewController
    private var segments: [UIViewController]

    private var currentSelectedIndex: Int?
    private var pageView: UIPageViewController?

    // MARK: - Public methods

    init(container: UIView, parent: UIViewController, segments: [UIViewController]) {
        self.pageViewContainer = container
        self.parent = parent
        self.segments = segments

        guard let firstController = segments.first else {
            return
        }

        configurePageView()
        selectPage(at: 0)
        pageView?.setViewControllers([firstController], direction: .forward, animated: false, completion: nil)
    }

    func selectPage(at index: Int) {
        let currentIndex = self.currentSelectedIndex ?? 0
        self.currentSelectedIndex = index

        let animationType: UIPageViewController.NavigationDirection = index > currentIndex ? .forward : .reverse

        let newController = [self.segments[index]]
        self.pageView?.setViewControllers(newController,
                                          direction: animationType,
                                          animated: true,
                                          completion: nil)
    }

}

// MARK: - Configuration

private extension Pager {

    func configurePageView() {
        // Add page view
        let pageView = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        parent.addChild(pageView)
        pageViewContainer.addSubview(pageView.view)

        pageView.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            pageView.view.topAnchor.constraint(equalTo: pageViewContainer.topAnchor),
            pageView.view.bottomAnchor.constraint(equalTo: pageViewContainer.bottomAnchor),
            pageView.view.leadingAnchor.constraint(equalTo: pageViewContainer.leadingAnchor),
            pageView.view.trailingAnchor.constraint(equalTo: pageViewContainer.trailingAnchor)
        ])
        pageView.didMove(toParent: self.parent)
        self.pageView = pageView
    }

}
