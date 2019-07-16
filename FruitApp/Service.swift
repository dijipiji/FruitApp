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
    static let statsURL:String = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/stats"

    enum StatType:String {
        case LOAD = "load"
        case DISPLAY = "display"
        case ERROR = "error"
    }
    
    /**
     *
     */
    static func getJSONData(query:String, callback: @escaping (Data?, Error?) -> Void) -> Bool {
        
        guard let myURL:URL = URL(string: query) else {
            return false
        }
        
        let session:URLSession = URLSession(configuration: URLSessionConfiguration.ephemeral)
        
        session.dataTask(with: myURL) {
            (data, response, error) in
            
            if error != nil {
                Service.sendStats(event:Service.StatType.ERROR,
                                  data:"Service:\(#function) line:\(#line), the URLSession is returning an error",
                                  callback:{ (data, error) -> Void in })
            }

            callback(data, error)
            session.finishTasksAndInvalidate()
            }.resume()
        
        return true
    }
    
    
    static func sendStats(event:StatType, data:Any, callback: @escaping (Data?, Error?) -> Void) {
        
        let params = ["event":event.rawValue, "data":data] as [String : Any]

        guard let myURL:URL = URL(string: statsURL) else {
            return
        }
        
        print("--->Service.sendStats with:stats?event=\(params["event"]!)&data=\(params["data"]!)")
        
        var request = URLRequest(url: myURL)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return
        }
        
        request.httpBody = httpBody
        
        let session:URLSession = URLSession(configuration: URLSessionConfiguration.ephemeral)
        
        session.dataTask(with: myURL) {
            (data, response, error) in
            
            callback(data, error)
            session.finishTasksAndInvalidate()
            }.resume()
   
    }
    
    
}
