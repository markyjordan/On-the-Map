//
//  StudentLocation.swift
//  On the Map
//
//  Created by Marky Jordan on 11/12/20.
//

import Foundation

struct StudentLocation: Codable {
    let createdAt: String?
    let firstName: String?
    let lastName: String?
    let latitude: Double?
    let longitude: Double?
    let mapString: String?
    let mediaURL: String?
    let objectId: String?
    let uniqueKey: String?
    let updatedAt: String?
    
    //  initialize a default value where a value for any given property is nil
    init(fromStudentData studentLocation: [String: Any]) {
        self.createdAt = studentLocation["createdAt"] as? String
        self.firstName = studentLocation["firstName"] as? String ?? ""
        self.lastName = studentLocation["lastName"] as? String ?? ""
        self.latitude = studentLocation["latitude"] as? Double ?? 0.0
        self.longitude = studentLocation["longitude"] as? Double ?? 0.0
        self.mapString = studentLocation["mapString"] as? String ?? ""
        self.mediaURL = studentLocation["mediaURL"] as? String ?? ""
        self.objectId = studentLocation["objectId"] as? String
        self.uniqueKey = studentLocation["uniqueKey"] as? String ?? ""
        self.updatedAt = studentLocation["updatedAt"] as? String
    }
}
