//
//  User.swift
//  sevcabel
//
//  Created by Ivan Smetanin on 11/11/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Foundation

struct User: Codable {

    private enum CodingKeys: String, CodingKey {
        case firstname = "first_name"
        case lastname = "last_name"
        case photoStringURL = "photo_200"
    }

    let firstname: String
    let lastname: String
    let photoStringURL: String


}
