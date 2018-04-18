//
//  HTTP.swift
//  splitwork
//
//  Created by Vivek Madhusudan Badrinarayan on 4/18/18.
//  Copyright © 2018 Vivek Badrinarayan. All rights reserved.
//

import Foundation

class HTTP {
    
    private static var sharedHTTP: HTTP = {
        let baseURL = "https://splitwork-app.firebaseio.com/"
        let http = HTTP(baseURL: baseURL)
        return http
    }()
    
    let baseURL: URL?
    
    private init(baseURL: String) {
        self.baseURL = URL(string: baseURL)
        print("HTTP initialized..")
    }
    
    class func shared() -> HTTP {
        return sharedHTTP
    }
    
    func get(url: String) {
        print("calling \(url)")
        // set up URL
        var result = [String: Any]()
        let endPoint = "\(String(describing: self.baseURL))\(url)"
        guard let url = URL(string: endPoint) else {
            print("Error: Cannot create URL (\(endPoint)")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up SESSION
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make REQUEST
        let task = session.dataTask(with: urlRequest, completionHandler: {
            data, response, error in
            // check for error
            guard error == nil else {
                print("Error: calling GET on \(endPoint)")
                return
            }
            // check for data
            guard let data = data else {
                print("Error: no data received on calling \(endPoint)")
                return
            }
            // parse data
            do {
                if let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Success: calling GET on \(endPoint)")
                    print(result)
                }
            } catch let error {
                print("Error: could not convert response to JSON")
            }
        })
        task.resume()
    }
}
