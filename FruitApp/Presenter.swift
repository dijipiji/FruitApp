//
//  Presenter.swift
//  FruitApp
//
//  Created by Jamie Lemon on 15/07/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import UIKit

class Presenter: NSObject {

    /**
     *
     */
    func getData(query:String = Service.baseURL,
                 callback:@escaping (Data?, Error?) -> Void) -> Bool {
        
        let validURL:Bool = Service.getJSONData(query:query, callback: { (data, error) -> Void in
            callback(data, error)
        })
        
       return validURL
    }
    
    
}
