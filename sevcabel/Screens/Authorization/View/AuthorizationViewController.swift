//
//  AuthorizationViewController.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 10/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit
import VK_ios_sdk

final class AuthorizationViewController: UIViewController {

    // MARK: - NSLayoutConstraints

    @IBOutlet private weak var backgroundImageViewTopConstraint: NSLayoutConstraint!

    // MARK: - IBActions

    @IBAction func vkAuthAction(_ sender: Any) {
        VKSdk.authorize(["offline", "email", "wall"])
    }

    // MARK: - Properties

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageViewTopConstraint.constant = UIApplication.shared.statusBarFrame.height
    }

    // MARK: - Internal helpers

}
