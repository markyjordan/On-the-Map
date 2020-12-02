//
//  UdacityClient.swift
//  On the Map
//
//  Created by Marky Jordan on 11/2/20.
//

import Foundation

class UdacityClient {
    
    static let apiKey = Constants.udacityUserAPIKey
    
    struct Auth {
        static var firstName = ""
        static var lastName = ""
        static var objectId = ""
        static var userId = ""
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        
        case login
        case signUp
        case getStudentLocation
        case addStudentLocation
        case updateStudentLocation
        case getUserInformation
        
        var urlString: String {
            switch self {
            case .login:
                return Endpoints.base + "/session"
            case .signUp:
                return Constants.udacityURLSignUp
            case .getStudentLocation:
                return Endpoints.base + "/StudentLocation?limit=100"
            case .addStudentLocation:
                return Endpoints.base + "/StudentLocation"
            case .updateStudentLocation:
                return Endpoints.base + "/StudentLocation/" + Auth.objectId
            case .getUserInformation:
                return Endpoints.base + "/users/" + Auth.userId
            }
        }
        
        // generate a URL from the endpoint's associated string value
        var url: URL {
            return URL(string: urlString)!
        }
    }
    
    
    class func login(email: String, password: String, completionHandler: @escaping (Bool, Error?) -> Void) {
        
    }
    
    class func getUserProfile(completionHandler: @escaping (Bool, Error?) -> Void) {
        
    }
    
    class func getStudentLocations(completionHandler: @escaping (Bool, Error?) -> Void) {
        
    }
    
    class func addStudentLocation {
        
    }
    
    class func updateStudentLocation {
        
    }
    
    class func logout(completionHandler: @escaping () -> Void {
        
    }
    
}
