//
//  StudentLocation.swift
//  On the Map
//
//  Created by Marky Jordan on 11/12/20.
//

import Foundation

struct StudentLocation: Codable {
    let createdAt: String
    let firstName: String
    let lastName: String
    let latitude: Float
    let longitude: Float
    let mapString: String
    let mediaURL: String
    let objectId: String
    let uniqueKey: String
    let updatedAt: String
}
