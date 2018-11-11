//
//  ZoomHelper.swift
//  sevcabel
//
//  Created by Anton Dryakhlykh on 11/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

final class Zoom{
    class func to(level: Double) -> Double {
        var result = 18.0
        switch level {
        case 1:
            result = 17.0
        case 2:
            result = 16.0
        case 3:
            result = 15.8
        default:
            result = 18.0
        }
        return result
    }

    class func change(level: Double, step: Int) -> Double {
        let newValue = level + Double(step)
        if newValue < 0 {
            return 0.0
        } else if newValue > 3 {
            return 3
        }
        return newValue

    }
}
