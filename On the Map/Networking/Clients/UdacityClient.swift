//
//  UdacityClient.swift
//  On the Map
//
//  Created by Marky Jordan on 11/2/20.
//

import Foundation

class UdacityNetworkClient {
    
    struct Auth {
        static var firstName = ""
        static var lastName = ""
        static var objectId = ""
        static var accountKey = ""
        static var sessionId = ""
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        
        case login
        case signUp
        case getStudentLocations
        case addStudentLocation
        case updateStudentLocation
        case getUserInformation
        
        var urlString: String {
            switch self {
            case .login:
                return Endpoints.base + "/session"
            case .signUp:
                return "https://auth.udacity.com/sign-up"
            case .getStudentLocations:
                return Endpoints.base + "/StudentLocation?limit=100"
            case .addStudentLocation:
                return Endpoints.base + "/StudentLocation"
            case .updateStudentLocation:
                return Endpoints.base + "/StudentLocation/" + Auth.objectId
            case .getUserInformation:
                return Endpoints.base + "/users/" + Auth.accountKey
            }
        }
        
        // generate a URL from the endpoint's associated string value
        var url: URL {
            return URL(string: urlString)!
        }
    }
    
    // MARK: - Network Request Methods
    
    class func login(email: String, password: String, completionHandler: @escaping (Bool, Error?) -> Void) {
        let requestBody = LoginRequest(udacity: LoginCredentials(username: "\(email)", password: "\(password)"))
        
        NetworkRequestHelper.taskForPOSTRequest(url: Endpoints.login.url, body: requestBody, responseType: LoginResponse.self) { (response, error) in
            if let response = response {
                Auth.accountKey = response.account.key
                Auth.sessionId = response.session.id
                
                completionHandler(true, nil)
            } else {
                completionHandler(false, nil)
            }
        }
    }
    
    class func getUserProfile(completionHandler: @escaping (Bool, Error?) -> Void) {
        NetworkRequestHelper.taskForGETRequest(url: Endpoints.getUserInformation.url, responseType: UserProfile.self) { (response, error) in
            if let response = response {
                Auth.firstName = response.firstName
                Auth.lastName = response.lastName
                completionHandler(true, nil)
            } else {
                completionHandler(false, error)
            }
        }
    }
    
    class func getStudentLocations(completionHandler: @escaping ([StudentLocation], Error?) -> Void) {
        NetworkRequestHelper.taskForGETRequest(url: Endpoints.getStudentLocations.url, responseType: GetStudentLocationResults.self) { (response, error) in
            if let response = response {
                completionHandler(response.results, nil)
            } else {
                completionHandler([], error)
            }
        }
    }
    
    class func addStudentLocation(mapData: StudentLocation, completionHandler: @escaping (Bool, Error?) -> Void) {
        let requestBody = StudentLocationRequest(uniqueKey: mapData.uniqueKey, firstName: mapData.firstName, lastName: mapData.lastName, mapString: mapData.mapString, mediaURL: mapData.mediaURL, latitude: mapData.latitude, longitude: mapData.longitude)
        
        NetworkRequestHelper.taskForPOSTRequest(url: Endpoints.addStudentLocation.url, body: requestBody, responseType: PostStudentLocationResponse.self) { (response, error) in
            if let response = response, response.createdAt != nil {
                Auth.objectId = response.objectId ?? ""
                completionHandler(true, nil)
            } else {
                completionHandler(false, nil)
            }
        }
    }
    
    class func updateStudentLocation(mapData: StudentLocation, completionHandler: @escaping (Bool, Error?) -> Void) {
        let requestBody = StudentLocationRequest(uniqueKey: mapData.uniqueKey, firstName: mapData.firstName, lastName: mapData.lastName, mapString: mapData.mapString, mediaURL: mapData.mediaURL, latitude: mapData.latitude, longitude: mapData.longitude)
        
        NetworkRequestHelper.taskForPUTRequest(url: Endpoints.updateStudentLocation.url, body: requestBody, responseType: UpdateStudentLocationResponse.self) { (response, error) in
            if let response = response, response.updatedAt != nil {
                completionHandler(true, nil)
            } else {
                completionHandler(false, error)
            }
        }
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
}
