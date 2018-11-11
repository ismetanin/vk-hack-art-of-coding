//
//  AttitudeSwitcher.swift
//  AttitudeSwitchTest
//
//  Created by Gregory Berngardt on 09/11/2018.
//  Copyright © 2018 gregoryvit. All rights reserved.
//

import Foundation
import CoreMotion

enum SwitchType {
    case up
    case down
}

class AttitudeSwitcher {
    
    private let manager = CMMotionManager()
    
    var switchHandler: ((SwitchType) -> ())?
    
    func start() {
        guard manager.isDeviceMotionAvailable else {
            return
        }
        
//        var initialAttitude = manager.deviceMotion!.attitude
        
        let pitchAnchorValue: Double = 0.60
        
        manager.startDeviceMotionUpdates(to: .main) { (data, error) in
            guard let data = data else {
                return
            }
            
//            data.attitude.multiply(byInverseOf: initialAttitude)
            
            if (data.attitude.pitch > pitchAnchorValue || data.attitude.pitch < -pitchAnchorValue) || abs(data.attitude.roll) > 2.5 {
                self.switchHandler?(SwitchType.up)
            } else {
                self.switchHandler?(SwitchType.down)
            }
            
//            print("Pitch: \(data.attitude.pitch), Roll: \(data.attitude.roll), Yaw: \(data.attitude.yaw)")
        }
    }
}
