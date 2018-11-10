//
//  UIImage.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 10/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit

extension UIImage {

    var isDark: Bool {
        get {
            return self.cgImage?.isDark ?? false
        }
    }

}
