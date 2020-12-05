//
//  UserProfile.swift
//  On the Map
//
//  Created by Marky Jordan on 11/16/20.
//

import Foundation

struct UserProfile: Codable {
    let firstName: String
    let lastName: String
    let nickName: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case nickName
    }
}
