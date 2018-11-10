//
//  AuthorizationViewController.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 10/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit

final class AuthorizationViewController: UIViewController {

    // MARK: - NSLayoutConstraints

    @IBOutlet private weak var backgroundImageViewTopConstraint: NSLayoutConstraint!

    // MARK: - Properties

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageViewTopConstraint.constant = UIApplication.shared.statusBarFrame.height
    }

    // MARK: - Internal helpers

}
