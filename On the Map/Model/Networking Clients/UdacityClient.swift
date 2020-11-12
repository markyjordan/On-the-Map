//
//  UdacityClient.swift
//  On the Map
//
//  Created by Marky Jordan on 11/2/20.
//

import Foundation

class UdacityClient {
    
    static let apiKey = myUdacityAPIKey
    
    struct Auth {
        static var firstName = ""
        static var lastName = ""
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        
        case login
        case signUp
        case getStudentLocation
        case addStudentLocation
        case updateStudentLocation
        case getUserInformation
        
        var stringValue: String {
            switch self {
            case .login:
                return
            case .signUp:
                return
            case .getStudentLocation:
                return
            case .addStudentLocation:
                return
            case .updateStudentLocation:
                return
            case .getUserInformation:
                return
            }
        }
        
        // generate a URL from the endpoint's associated string value
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
}
