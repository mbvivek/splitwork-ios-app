//
//  HTTP.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/18/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import Foundation

class HTTPService {
    
    private static var sharedHTTP: HTTPService = {
        let baseURL = "https://splitwork-app.firebaseio.com/"
        let http = HTTPService(baseURL: baseURL)
        return http
    }()
    
    let baseURL: URL?
    
    private init(baseURL: String) {
        self.baseURL = URL(string: baseURL)
        print("HTTPService initialized..")
    }
    
    class func shared() -> HTTPService {
        return sharedHTTP
    }
    
    func get(url: String, completionHandler: ((String, [String: Any]) -> ())?) {
        print("Calling GET on \(url)")
        // set up URL
        var result = [String: Any]()
        let endPoint = "\(self.baseURL!)\(url).json"
        guard let url = URL(string: endPoint) else {
            let error = String("Error: Cannot create URL (\(endPoint)")
            completionHandler?(error, result)
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        // set up SESSION
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make REQUEST
        let task = session.dataTask(with: urlRequest, completionHandler: {
            data, response, error in
            // check for error
            guard error == nil else {
                let error = String("Error: Error calling \(endPoint) [GET]")
                completionHandler?(error, result)
                return
            }
            // check for data
            guard let data = data else {
                let error = String("Error: No data received on calling \(endPoint)")
                completionHandler?(error, result)
                return
            }
            // parse data
            do {
                if let res = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    result = ["data": res]
                    completionHandler?("", result)
                } else if let res = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    result = ["data": res]
                    completionHandler?("", result)
                } else {
                    print("Error: Could not parse response from \(endPoint)")
                    let error = "Error: Could not parse response from (\(endPoint)"
                    completionHandler?(error, result)
                }
            } catch _ {
                print("Error: Could not parse response from \(endPoint)")
                let error = "Error: Could not parse response from (\(endPoint)"
                completionHandler?(error, result)
            }
        })
        task.resume()
    }
    
    func put(url: String, data: [String: Any], completionHandler: ((String, [String: Any]) -> ())?) {
        print("Calling PUT on \(url)")
        // set up URL
        var result = [String: Any]()
        let endPoint = "\(self.baseURL!)\(url).json"
        guard let url = URL(string: endPoint) else {
            let error = String("Error: Cannot create URL (\(endPoint)")
            completionHandler?(error, result)
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        
        // set up the data
        let jsonData = try? JSONSerialization.data(withJSONObject: data, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)
        urlRequest.httpBody = jsonString?.data(using: .utf8)
        
        // set up SESSION
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make REQUEST
        let task = session.dataTask(with: urlRequest, completionHandler: {
            data, response, error in
            // check for error
            guard error == nil else {
                let error = String("Error: Error calling \(endPoint) [PUT]")
                completionHandler?(error, result)
                return
            }
            // check for data
            guard let data = data else {
                let error = String("Error: No data received on calling \(endPoint)")
                completionHandler?(error, result)
                return
            }
            // parse data
            do {
                if let res = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    result = ["data": res]
                    completionHandler?("", result)
                } else if let res = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    result = ["data": res]
                    completionHandler?("", result)
                } else {
                    print("Error: Could not parse response from \(endPoint)")
                    let error = "Error: Could not parse response from (\(endPoint)"
                    completionHandler?(error, result)
                }
            } catch _ {
                print("Error: Could not parse response from \(endPoint)")
                let error = "Error: Could not parse response from (\(endPoint)"
                completionHandler?(error, result)
            }
        })
        task.resume()
    }
}

