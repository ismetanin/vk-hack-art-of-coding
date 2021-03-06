//
//  NSObject.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 10/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Foundation

public extension NSObject {

    class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

}
