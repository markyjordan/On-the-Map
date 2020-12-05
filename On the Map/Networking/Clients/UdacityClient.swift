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
        static var accountKey = ""
        static var sessionId = ""
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
    
    class func logout(completionHandler: @escaping () -> Void) {
        var request = URLRequest(url: Endpoints.login.url)
        request.httpMethod = "DELETE"
        
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        
        let sharedSession = URLSession.shared
        
        let task = sharedSession.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("Logout error occurred.")
                return
            }
            let range = 5..<data!.count
            let newData = data?.subdata(in: range)
            print(String(data: newData!, encoding: .utf8)!)
            
            Auth.sessionId = ""
            completionHandler()
        }
        task.resume()
    }
    
    class func getUserProfile(completionHandler: @escaping (Bool, Error?) -> Void) {
        
    }
    
    class func getStudentLocations(completionHandler: @escaping (Bool, Error?) -> Void) {
        
    }
    
    class func addStudentLocation {
        
    }
    
    class func updateStudentLocation {
        
    }
    
}
