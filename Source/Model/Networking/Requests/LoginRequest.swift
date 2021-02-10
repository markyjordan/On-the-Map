//
//  LoginRequest.swift
//  On the Map
//
//  Created by Marky Jordan on 12/1/20.
//

import Foundation

struct LoginCredentials: Codable {
    let username: String
    let password: String
}

struct LoginRequest: Codable {
    let udacity: LoginCredentials
}
