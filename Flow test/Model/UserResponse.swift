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


struct User: Codable {
    let id: Int
    let email: String
    let first_name: String
    let last_name: String
    let avatar: String
}
