//
//  LoginResponse.swift
//  On the Map
//
//  Created by Marky Jordan on 12/4/20.
//

import Foundation

//struct Session: Codable {
//    let id: String
//    let expiration: String
//}

struct Account: Codable {
    let registered: Bool
    let key: String
}

struct LoginResponse: Codable {
    let account: Account
    let session: Session
}
