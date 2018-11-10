//
//  UserDefaults.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 10/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Foundation

extension UserDefaults {

    var isUserAuthorized: Bool {
        get { return bool(forKey: #function) }
        set { set(newValue, forKey: #function) }
    }

}
