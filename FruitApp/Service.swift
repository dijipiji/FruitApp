//
//  Service.swift
//  FruitApp
//
//  Created by Jamie Lemon on 15/07/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import Foundation

class Service: NSObject {

    static let baseURL:String = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/data.json"
    
    /**
     *
     */
    static func getJSONData(query:String, callback: @escaping (Data?, Error?) -> Void) -> Bool {
        
        guard let myURL:URL = URL(string: query) else {
            return false
        }
        
        let session:URLSession = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: myURL) {
            (data, response, error) in

            callback(data, error)
            }.resume()
        
        return true
    }
    
}
