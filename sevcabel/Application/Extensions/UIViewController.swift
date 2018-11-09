//
//  UIViewController.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 09/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit

extension UIViewController {

    class func fromStoryboard() -> UIViewController {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: Bundle.main)
        return storyboard.instantiateInitialViewController()!
    }

}
