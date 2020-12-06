//
//  PostStudentLocationRequest.swift
//  On the Map
//
//  Created by Marky Jordan on 12/5/20.
//

import Foundation

struct PostStudentLocationRequest: Codable {
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Float
    let longitude: Float
}

