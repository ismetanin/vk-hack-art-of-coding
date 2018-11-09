//
//  TabBar.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 10/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit

final class TabBar: UITabBarController {

    // MARK: - UITabBarController

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        tabBar.tintColor = .white
        tabBar.barTintColor = UIColor(red: 0.22, green: 0.3, blue: 0.82, alpha: 1)
        selectedIndex = 0
        self.setViewControllers(tabBarControllers(), animated: false)
    }

    // MARK: - Private methods

    private func tabBarControllers() -> [UIViewController] {
        var controllers: [UIViewController] = []

        let now = UIViewController()
        now.tabBarItem = UITabBarItem(
            title: "Сейчас",
            image: UIImage(named: "maps-and-flags"),
            tag: 0
        )
        now.view.backgroundColor = .white
        controllers.append(now)

        let feed = FeedViewController.fromStoryboard()
        feed.tabBarItem = UITabBarItem(
            title: "Севкабель",
            image: UIImage(named: "feed"),
            tag: 0
        )
        controllers.append(feed)

        let profile = UIViewController()
        profile.view.backgroundColor = .white
        profile.tabBarItem = UITabBarItem(
            title: "Профиль",
            image: UIImage(named: "profile"),
            tag: 0
        )
        controllers.append(profile)

        return controllers
    }

}
