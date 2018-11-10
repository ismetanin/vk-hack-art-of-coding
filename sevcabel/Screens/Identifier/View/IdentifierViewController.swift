//
//  IdentifierViewController.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 11/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit

final class IdentifierViewController: UIViewController {

    // MARK: - Properties

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGr = UITapGestureRecognizer(target: self, action: #selector(contentTap))
        view.addGestureRecognizer(tapGr)
    }

    // MARK: - Private methods

    @objc private func contentTap() {
        dismiss(animated: true, completion: nil)
    }

}
