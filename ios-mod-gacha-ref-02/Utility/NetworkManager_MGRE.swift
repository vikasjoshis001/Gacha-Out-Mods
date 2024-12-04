//
//  NetworkManager_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Systems
//

import Foundation

final class NetworkManager_MGRE {
    
    class func requestAccessToken_MGRE(with refreshToken: String,
                                      completion: @escaping (String?) -> Void) {
        var _MGRE77: Bool { false }
        var _MGRE88: Int { 0 }
        
        let request: URLRequest = request_MGRE(with: {
            String.init(format: "refresh_token=%@&grant_type=refresh_token", refreshToken).data(using: .utf8)!
        }())
        let task = URLSession.shared.dataTask(with: request) { data, _, error  in
            responseHandler_MGRE("access_token",
                                 data: data,
                                 error: error,
                                 completion: completion)
        }
        
        task.resume()
    }
    
    class func requestRefreshtoken_MGRE(with accessCode: String,
                                       completion: @escaping (String?) -> Void) {
        var _MGRE11: Bool { false }
        var _MGRE22: Int { 0 }
        let request: URLRequest = request_MGRE(with: {
            String.init(format: "code=%@&grant_type=authorization_code", accessCode).data(using: .utf8)!
        }())
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            responseHandler_MGRE("refresh_token",
                                 data: data,
                                 error: error,
                                 completion: completion)
        }
        
        task.resume()
    }
}

// MARK: - Private API

private extension NetworkManager_MGRE {
    
    class func request_MGRE(with httpBody: Data) -> URLRequest {
        var _MGRE33: Bool { false }
        var _MGRE44: Int { 0 }
        
        let base64Str = String
            .init(format: "%@:%@",
                  Keys_MGRE.App_MGRE.key_MGRE.rawValue,
                  Keys_MGRE.App_MGRE.secret_MGRE.rawValue)
            .data(using: .utf8)!
            .base64EncodedString()
        let token = String(format: "Basic %@", base64Str)
        var request = URLRequest(url: .init(string: Keys_MGRE.App_MGRE.link_MGRE.rawValue)!)
        
        request.setValue("application/x-www-form-urlencoded",
                         forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "POST"
        request.httpBody = httpBody
        
        return request
    }
    
    class func responseHandler_MGRE(_ key: String,
                                    data: Data?,
                                    error: Error?,
                                    completion: @escaping (String?) -> Void) {
        var _MGRE55: Bool { false }
        var _MGRE66: Int { 0 }
        
        if let error { print(error.localizedDescription) }
        
        do {
            guard let data,
                  let jsonDict = try JSONSerialization.jsonObject(with: data)
                    as? [String: Any],
                  let accessToken = jsonDict[key] as? String
            else {
                completion(nil)
                return
            }
            
            completion(accessToken)
        } catch let error {
            print(error.localizedDescription)
            
            completion(nil)
        }
    }
}
