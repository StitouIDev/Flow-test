//
//  UserResponse.swift
//  Flow test
//
//  Created by HAMZA on 24/7/2022.
//

import Foundation

struct UserResponse: Codable {
    let data: [User]
}

// MARK: Model contains the data fetched from APi


struct User: Codable {
    let id: Int
    let email: String
    var first_name: String
    var last_name: String
    let avatar: String
}
