//
//  UIView.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 10/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import UIKit

public func instancetype<T>(object: Any?) -> T? {
    return object as? T
}

extension UIView {

    class func fromXib(_ name: String? = nil) -> Self? {
        return instancetype(object: Bundle.main.loadNibNamed(name ?? String(describing: self.self), owner: nil, options: nil)?.last)
    }

}

