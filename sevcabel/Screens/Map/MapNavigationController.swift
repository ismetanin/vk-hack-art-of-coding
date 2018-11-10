//
//  MapNavigationController.swift
//  sevcabel
//
//  Created by Anton Dryakhlykh on 10/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit

final class MapNavigationController: UINavigationController {

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
    }
}
