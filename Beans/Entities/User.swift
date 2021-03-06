//
//  User.swift
//  Beans
//
//  Created by Ricardo Gehrke on 10/01/21.
//

import Foundation

struct User: Codable, Equatable {
    let name: String
    let email: String
    let token: String
}
